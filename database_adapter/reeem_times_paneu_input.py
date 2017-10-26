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
    path = (r'G:\\dtu\\reeem_db\\database\\database_adapter\\data\\TIMES_PANEU\\')
    file = 'REEEM_TIMES_PanEU_Input_F1_TI1_P1.xlsx'  #'REEEM_TIMES_PanEU_Input.xlsx'
    logger = log()
    # logger.info('...read file: {}'.format(file))
    xls = pd.ExcelFile(path+file)
    sheet = region
    logger.info('...read sheet: {}'.format(sheet))
    df = pd.read_excel(xls, sheet, header=4, index_col='ID') # header=1
    df.columns = ['name','unit','2010','2015','2020','2025','2030','2035',
        '2040','2045','2050','table','aggregation','source'] # add source
    df.index.names = ['nid']
    # logger.info('...read data...')
    # print(df.dtypes)
    # print(df.head())
    
    # seperate columns
    dfunit = df[['table','name','unit','aggregation','source']].copy().dropna() # add source
    dfunit.index.names = ['nid']
    dfunit.columns = ['table','name','unit','aggregation','source'] # add source
    # print(dfunit)
    # print(dfunit.dtypes)

    # drop seperated columns
    dfclean = df.drop(['table','name','unit','aggregation','source'],axis=1).dropna() # add source
    # print(dfclean)
    
    # stack
    dfstack = dfclean.stack().reset_index()
    dfstack.columns = ['nid','year','value']
    # dfstack.set_index(['nid','year'], inplace=True)
    dfstack.index.names = ['id']
    # print(dfstack)
    
    # database dataframe
    # logger.info('...reshape dataframe...')
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
        name='times_paneu_service', 
        if_exists='append',
        index = True )
    logger.info('...dataframe sucessfully imported...')


if __name__ == '__main__':
    logger = log()
    start_time = time.time()
    logger.info('script started...')
    con = reeem_session()
    version = 'F1_TI1_P1' # F1_TI1_P1
    # region = 'EU28'
    # excel_dataframe(version, region, con)
    regions = ['EU28', 'AT', 'BE', 'BG', 'CY', 'CZ', 'DE', 'DK', 'EE', 'ES', 
        'FI', 'FR', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LU', 'LV', 'MT', 'NL', 
        'PL', 'PT', 'RO', 'SE', 'SI', 'SK', 'UK']
    #regions = ['EU28', 'AT', 'BE' ]
    for region in regions:
        excel_dataframe(version, region, con)
    reeem_scenario_log(con,version,'import', 'model_draft',
        'times_paneu_service','reeem_times_paneu_service_input.py',
        'REEEM_TIMES_PanEU_Input_F1_TI1_P1.xlsx') # add new filename
    con.close()
    logger.info('...database connection closed...')
    logger.info('...script successfully executed in {:.2f} seconds. Goodbye!'
        .format(time.time() - start_time))
