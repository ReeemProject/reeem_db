"""read data from database and write to file"""

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/23"
__version__     = "v0.1.1"

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
model = 'UCL Model'
pathway = 'Test_data'       # 'BASE', 'BASE_TI1_P1', 'BASE_TI1_P2', 'Test_data', 'Pilot'
version = 'V1'              # 'V2', 'V3'

file_name = 'REEEM_db_output_ucl.xlsx'

regions = ['AT']
# regions = ['EU28', 'AT', 'BE', 'BG', 'CY', 'CZ', 'DE', 'DK', 'EE', 'ES', 
#     'FI', 'FR', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LU', 'LV', 
#     'MT', 'NL', 'PL', 'PT', 'RO', 'SE', 'SI', 'SK', 'UK']

db_schema = 'model_draft'
db_table = 'reeem_times_paneu_input'
indicator = '(nid = \'70\' OR nid = \'63\')'
sql = text('SELECT * FROM {}.{} '
    'WHERE pathway = \'{}\' AND {}'.format(db_schema,db_table,pathway,indicator))


## functions
def reeem_db_pathway(log, writer):
    """read database pathway and write to excel sheet"""
    
    # select pathways
    log.info('...query pathways...')
    db_schema_pathway = 'model_draft'
    db_table_pathway = 'reeem_pathway'
    sql_pathway = text('SELECT * FROM {}.{}'.format(db_schema_pathway,db_table_pathway))
    # print(sql_pathway)
    
    df_pathway = pd.read_sql_query(sql_pathway, con).loc[:,['id', 'pathway']]
    # print (df_pathway)
    
    df_pathway.to_excel(writer,'pathways')
    log.info('...write pathways to file...')


def reeem_db_2_excel(log, model, pathway, version, file_name, sql, con):
    """read database and write to excel file"""
    
    ## data
    # select data
    log.info('...execute SQL query...')
    print(sql)
    
    df = pd.read_sql_query(sql, con)
    # print (df)
    
    df.to_excel(writer,'data',startrow=4,index = False)
    
    # add header
    today = datetime.date.today()
    header_data = [pathway,version,today.isoformat()]
    header_columns = ['pathway','version','date']
    df_header = pd.DataFrame(data=header_data).T
    df_header.columns = header_columns
    # print(df_header.T)
    
    df_header.to_excel(writer,'data',index = False)
    
    ## data_unstack
    # seperate columns
    dfunit = df[['nid', 'pathway', 'version', 'region', 'field', 'category', 
    'indicator', 'unit', 'aggregation', 'updated', 'source']].copy().dropna()
    dfunit = dfunit.drop_duplicates(subset=['nid', 'pathway', 'version', 
    'region', 'unit', 'aggregation', 'source' ], keep='first')
    # dfunit.index.names = ['nid']
    # print(dfunit.head())
    print(dfunit)
    
    # drop seperated columns
    dfclean = df.drop(['id','dfid', 'pathway', 'version', 'region', 'field', 'category', 
    'indicator', 'unit', 'aggregation', 'updated', 'source'],axis=1).dropna()
    # print(dfclean.head())
    # print(dfclean)
    
    # unstack dataframe
    # dfunstack = dfclean.reset_index().pivot(columns='year', index='nid', values='value')
    dfunstack = dfclean.reset_index().pivot(columns='year', index='nid', values='value').reset_index()
    # print(dfunstack)
    
    # join dataframe with units
    # dfxls = dfunstack.join(dfunit, on='nid')
    dfxls = dfunstack.merge(dfunit, on='nid', how='left', indicator=True)
    print(dfxls)
    
    dfxls.to_excel(writer,'data_unstack',startrow=4,index = False)
    
    # add header
    today = datetime.date.today()
    header_data = [pathway,version,today.isoformat()]
    header_columns = ['pathway','version','date']
    df_header = pd.DataFrame(data=header_data).T
    df_header.columns = header_columns
    # print(df_header.T)
    
    df_header.to_excel(writer,'data_unstack',index = False)


if __name__ == '__main__':
    # logging
    log = logger()
    start_time = time.time()
    log.info('script started...')
    log.info('...pathway: {}'.format(pathway))
    log.info('...model: {}'.format(model))
    log.info('...version: {}'.format(version))
    log.info('...establish database connection...')
    
    # connection
    con = reeem_session()
    path = os.path.join('Model_Data', pathway, model, file_name)
    writer = pd.ExcelWriter(path) # define excel file
    
    # sql
    reeem_db_pathway(log, writer)
    reeem_db_2_excel(log, model, pathway, version, file_name, sql, con)
    
    # scenario log
    reeem_scenario_log(con, version, 'export', db_schema, db_table,
        os.path.basename(__file__), file_name)
    
    # close connection
    writer.save() # write to excel
    con.close()
    log.info('...script successfully executed in {:.2f} seconds...'
        .format(time.time() - start_time))
    log.info('...database connection closed. Goodbye!')
