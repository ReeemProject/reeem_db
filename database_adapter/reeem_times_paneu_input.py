"""read data from excel and write to database"""

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__version__     = "v0.1.0"

import os
import sys
import getpass
import logging
import time
import datetime
import pandas as pd
import numpy as np
from reeem_io import *
from sqlalchemy import *


## inputs
model = 'TIMES PanEU'
pathway = 'Test_data'       # 'BASE', 'BASE_TI1_P1', 'BASE_TI1_P2', 'Test_data', 'Pilot'
version = 'V1'              # 'V2', 'V3'

# regions = ['EU28', 'AT', 'BE', 'BG', 'CY', 'CZ', 'DE', 'DK', 'EE', 'ES', 
#     'FI', 'FR', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LU', 'LV', 
#     'MT', 'NL', 'PL', 'PT', 'RO', 'SE', 'SI', 'SK', 'UK']
regions = ['EU28', 'AT']

file_name = 'REEEM_TIMES_PanEU_Input_Structure.xlsx'
# file_name = 'REEEM_TIMES_PanEU_Input_BASE.xlsx'
# file_name = 'REEEM_TIMES_PanEU_Input_F1_TI1_P1.xlsx'  
# file_name = 'REEEM_TIMES_PanEU_Input.xlsx'

empty_rows = 4
column_names = ['indicator', 'unit', 
        '2010', '2015', '2020', '2025', '2030', '2035', '2040', '2045', '2050',
        'field', 'category', 'aggregation', 'source']

# database table
db_schema = 'model_draft' 
db_table = 'reeem_times_paneu_input' 


## functions
def times_paneu_2_reeem_db(model, pathway, version, file_name, empty_rows, column_names, db_schema, db_table, region, con):
    """read excel file and sheets, make dataframe and write to database"""
    
    logger = log()
    
    ## read file
    path = os.path.join('Model_Data', pathway, model, file_name)
    xls = pd.ExcelFile(path)
    df = pd.read_excel(xls, region, header=empty_rows, index_col='ID')
    logger.info('...read sheet: {}'.format(region))
    
    ## make dataframe
    df.columns = column_names
    df.index.names = ['nid']
    # print(df.dtypes)
    # print(df.head())
    
    ## seperate columns
    dfunit = df[['field', 'category', 'indicator', 'unit', 'aggregation', 'source']].copy().dropna()
    dfunit.index.names = ['nid']
    dfunit.columns = ['field', 'category', 'indicator', 'unit', 'aggregation', 'source']
    # print(dfunit)
    # print(dfunit.dtypes)
    
    ## drop seperated columns
    dfclean = df.drop(['field', 'category', 'indicator', 'unit', 'aggregation', 'source'],axis=1).dropna()
    # print(dfclean)
    
    ## stack dataframe
    dfstack = dfclean.stack().reset_index()
    dfstack.columns = ['nid','year','value']
    # dfstack.set_index(['nid','year'], inplace=True)
    dfstack.index.names = ['id']
    # print(dfstack)

    # join dataframe for database
    dfdb = dfstack.join(dfunit, on='nid')
    dfdb.index.names = ['dfid']
    dfdb['pathway'] = pathway
    dfdb['version'] = version
    dfdb['region'] = region
    dfdb['updated'] = (datetime.datetime.fromtimestamp(time.time())
        .strftime('%Y-%m-%d %H:%M:%S'))
    # print(dfdb)
    
    # copy dataframe to database
    dfdb.to_sql(con = con, 
        schema = db_schema,
        name = db_table, 
        if_exists='append',
        index = True )
    logger.info('......sheet {} sucessfully imported...'.format(region))


if __name__ == '__main__':
    # logging
    logger = log()
    start_time = time.time()
    logger.info('script started...')
    logger.info('...pathway: {}'.format(pathway))
    logger.info('...model: {}'.format(model))
    logger.info('...version: {}'.format(version))
    logger.info('...regions: {}'.format(regions))
    logger.info('...read file: {}'.format(file_name))
    logger.info('...establish database connection...')
    
    # 
    con = reeem_session()
    for region in regions:
        times_paneu_2_reeem_db(model, pathway, version, file_name, empty_rows, 
            column_names, db_schema, db_table, region, con)
    
    # scenario log
    reeem_scenario_log(con,version,'import', db_schema, db_table,
        os.path.basename(__file__), file_name)
    
    # close connection
    con.close()
    logger.info('...script successfully executed in {:.2f} seconds...'
        .format(time.time() - start_time))
    logger.info('...database connection closed. Goodbye!')
