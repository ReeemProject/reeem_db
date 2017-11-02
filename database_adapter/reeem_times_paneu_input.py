"""read data from excel and write to database"""

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"

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

# configure logging
def log():
    logger = logging.getLogger('EEEE')
    logger.setLevel(logging.INFO)
    ch = logging.StreamHandler()
    ch.setLevel(logging.INFO)
    formatter = logging.Formatter('%(asctime)s %(message)s',
                                    datefmt='%Y-%m-%d %I:%M:%S')
    return logger

def excel_dataframe(version, region, con):
    """read excel file and sheets and make dataframe"""
    
    # read data from file
    pathway = 'Test_data'
    file = 'REEEM_TIMES_PanEU_Input_Structure.xlsx'
    
    # file = 'REEEM_TIMES_PanEU_Input_F1_TI1_P1.xlsx'  
    # file = 'REEEM_TIMES_PanEU_Input.xlsx'
    
    #path = (r'G:\\github\\ReeemProject\\reeem_db\\database_adapter\\Model_Data\\Test_data')
    path = os.path.join('Model_Data', pathway, 'TIMES PanEU',file)
    
    logger = log()
    # logger.info('...read file: {}'.format(file))
    xls = pd.ExcelFile(path)
    sheet = region
    logger.info('...read sheet: {}'.format(sheet))
    
    df = pd.read_excel(xls, sheet, header=4, index_col='ID')
    df.columns = ['indicator', 'unit', 
        '2010', '2015', '2020', '2025', '2030', '2035', '2040', '2045', '2050',
        'field', 'category', 'aggregation', 'source']
    df.index.names = ['nid']
    logger.info('...read data...')
    # print(df.dtypes)
    # print(df.head())
    
    # seperate columns
    dfunit = df[['field', 'category', 'indicator', 'unit', 'aggregation', 'source']].copy().dropna()
    dfunit.index.names = ['nid']
    dfunit.columns = ['field', 'category', 'indicator', 'unit', 'aggregation', 'source']
    # print(dfunit)
    # print(dfunit.dtypes)

    # drop seperated columns
    dfclean = df.drop(['field', 'category', 'indicator', 'unit', 'aggregation', 'source'],axis=1).dropna()
    # print(dfclean)
    
    # stack
    dfstack = dfclean.stack().reset_index()
    dfstack.columns = ['nid','year','value']
    # dfstack.set_index(['nid','year'], inplace=True)
    dfstack.index.names = ['id']
    # print(dfstack)
    
    # database dataframe
    logger.info('...reshape dataframe...')
    dfdb = dfstack.join(dfunit, on='nid')
    dfdb.index.names = ['dfid']
    dfdb['region'] = region
    dfdb['version'] = version
    dfdb['updated'] = (datetime.datetime.fromtimestamp(time.time())
        .strftime('%Y-%m-%d %H:%M:%S'))
    # print(dfdb)
    
    # copy dataframe to database
    dfdb.to_sql(con=con, 
        schema='model_draft', 
        name='reeem_times_paneu_input', 
        if_exists='append',
        index = True )
    logger.info('...dataframe sucessfully imported...')


if __name__ == '__main__':
    logger = log()
    start_time = time.time()
    logger.info('script started...')
    logger.info('...establish database connection...')
    con = reeem_session()
    version = 'Test_data' # 'F1_TI1_P1' # 'F1_TI1_P1'
    # region = 'EU28'
    # excel_dataframe(version, region, con)
    #regions = ['EU28', 'AT', 'BE', 'BG', 'CY', 'CZ', 'DE', 'DK', 'EE', 'ES', 
    #    'FI', 'FR', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LU', 'LV', 'MT', 'NL', 
    #    'PL', 'PT', 'RO', 'SE', 'SI', 'SK', 'UK']
    regions = ['EU28', 'AT', 'BE' ]
    for region in regions:
        excel_dataframe(version, region, con)
    reeem_scenario_log(con,version,'import', 'model_draft',
        'reeem_times_paneu_input','reeem_times_paneu_input.py',
        'REEEM_TIMES_PanEU_Input_Structure.xlsx') # add new filename
    con.close()
    logger.info('...database connection closed...')
    logger.info('...script successfully executed in {:.2f} seconds. Goodbye!'
        .format(time.time() - start_time))
