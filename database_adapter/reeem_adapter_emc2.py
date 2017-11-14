"""read data from file and write to database"""

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
model = 'EMC2'
pathway = 'Test_data'       # 'BASE', 'BASE_TI1_P1', 'BASE_TI1_P2', 'Test_data', 'Pilot'
version = 'V1'              # 'V2', 'V3'

#file
file_name_input = 'REEEM_EMC2_Input.csv'
file_name_output = 'REEEM_EMC2_Output.csv'

# database table
db_schema = 'model_draft' 
db_table_input = 'reeem_emc2_input' 
db_table_output = 'reeem_emc2_output' 

## functions
def emc2_input_2_reeem_db(model, pathway, version, 
    file_name_input, db_schema, db_table, con):
    """read input file, make dataframe and write to database"""
    
    logger = log()
    
    ## read file
    csv = os.path.join('Model_Data', pathway, model, file_name_input)
    df = pd.read_csv(csv, sep=';', index_col='id')
    
    ## make dataframe
    df.columns = ['region','indicator','sector_id','year','value', 'unit','notation']
    df.index.names = ['nid']
    # print(df.dtypes)
    # print(df.head())

    # join dataframe for database
    df['pathway'] = pathway
    df['version'] = version
    df['updated'] = (datetime.datetime.fromtimestamp(time.time())
        .strftime('%Y-%m-%d %H:%M:%S'))
    # print(df)
    
    # copy dataframe to database
    df.to_sql(con = con, 
        schema = db_schema,
        name = db_table_input, 
        if_exists='append',
        index = True )
    logger.info('......file {} sucessfully imported...'.format(file_name_input))


def emc2_output_2_reeem_db(model, pathway, version, 
    file_name_output, db_schema, db_table_output, con):
    """read input file, make dataframe and write to database"""
    
    logger = log()
    
    ## read file
    csv = os.path.join('Model_Data', pathway, model, file_name_output)
    df = pd.read_csv(csv, sep=';', index_col='GRID_5km_ID')
    
    ## make dataframe
    df.columns = ['region', 'snap1', 'indicator','year','value', 'unit']
    df.index.names = ['grid_id']
    # print(df.dtypes)
    # print(df.head())

    # join dataframe for database
    df['pathway'] = pathway
    df['version'] = version
    df['updated'] = (datetime.datetime.fromtimestamp(time.time())
        .strftime('%Y-%m-%d %H:%M:%S'))
    # print(df)
    
    # copy dataframe to database
    df.to_sql(con = con, 
        schema = db_schema,
        name = db_table_output, 
        if_exists='append',
        index = False )
    logger.info('......file {} sucessfully imported...'.format(file_name_output))


if __name__ == '__main__':
    # logging
    logger = log()
    start_time = time.time()
    logger.info('script started...')
    logger.info('...pathway: {}'.format(pathway))
    logger.info('...model: {}'.format(model))
    logger.info('...version: {}'.format(version))
    logger.info('...read file: {}'.format(file_name_input))
    logger.info('...read file: {}'.format(file_name_output))
    logger.info('...establish database connection...')
    
    # connection
    con = reeem_session()
    
    # input
    emc2_input_2_reeem_db(model, pathway, version, file_name_input, 
        db_schema, db_table_input, con)
    
    # scenario log
    reeem_scenario_log(con,version,'import', db_schema, db_table_input,
        os.path.basename(__file__), file_name_input)
    
    # output
    emc2_output_2_reeem_db(model, pathway, version, file_name_output, 
        db_schema, db_table_output, con)
    
    # scenario log
    reeem_scenario_log(con,version,'import', db_schema, db_table_output,
        os.path.basename(__file__), file_name_output)
    
    
    # close connection
    con.close()
    logger.info('...script successfully executed in {:.2f} seconds...'
        .format(time.time() - start_time))
    logger.info('...database connection closed. Goodbye!')
