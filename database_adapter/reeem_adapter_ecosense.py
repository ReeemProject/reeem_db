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
model = 'EcoSense'
pathway = 'Test_data'       # 'BASE', 'BASE_TI1_P1', 'BASE_TI1_P2', 'Test_data', 'Pilot'
version = 'V1'              # 'V2', 'V3'

#file
file_name_input = 'REEEM_Ecosense_Input.csv'
file_name_output = 'REEEM_Ecosense_Output.csv'

# database table
db_schema = 'model_draft' 
db_table_input = 'reeem_ecosense_input' 
db_table_output = 'reeem_ecosense_output' 

## functions
def ecosense_input_2_reeem_db(model, pathway, version, 
    file_name_input, db_schema, db_table, con):
    """read input file, make dataframe and write to database"""
    
    log = logger()
    
    ## read file
    csv = os.path.join('Model_Data', pathway, model, file_name_input)
    df = pd.read_csv(csv, sep=';', index_col='nid')
    
    ## make dataframe
    df.columns = ['region','sector_id','sector_name','value','indicator','year','scenario_name','unit']
    # df.index.names = ['nid']
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
    log.info('......file {} sucessfully imported...'.format(file_name_input))


def ecosense_output_2_reeem_db(model, pathway, version, 
    file_name_output, db_schema, db_table_output, con):
    """read input file, make dataframe and write to database"""
    
    log = logger()
    
    ## read file
    csv = os.path.join('Model_Data', pathway, model, file_name_output)
    df = pd.read_csv(csv, sep=';', index_col='nid')
    
    ## make dataframe
    df.columns = ['indicator','region_iso','value_daly','value_euro']
    # df.index.names = ['nid']
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
        index = True )
    log.info('......file {} sucessfully imported...'.format(file_name_output))


if __name__ == '__main__':
    # logging
    log = logger()
    start_time = time.time()
    log.info('script started...')
    log.info('...pathway: {}'.format(pathway))
    log.info('...model: {}'.format(model))
    log.info('...version: {}'.format(version))
    log.info('...read file: {}'.format(file_name_input))
    log.info('...read file: {}'.format(file_name_output))
    log.info('...establish database connection...')
    
    # connection
    con = reeem_session()
    
    # input
    ecosense_input_2_reeem_db(model, pathway, version, file_name_input, 
        db_schema, db_table_input, con)
    
    # scenario log
    reeem_scenario_log(con,version,'import', db_schema, db_table_input,
        os.path.basename(__file__), file_name_input)
    
    # output
    ecosense_output_2_reeem_db(model, pathway, version, file_name_output, 
        db_schema, db_table_output, con)
    
    # scenario log
    reeem_scenario_log(con,version,'import', db_schema, db_table_output,
        os.path.basename(__file__), file_name_output)
    
    
    # close connection
    con.close()
    log.info('...script successfully executed in {:.2f} seconds...'
        .format(time.time() - start_time))
    log.info('...database connection closed. Goodbye!')
