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
    'WHERE pathway = \'{}\' '
    'AND version = \'{}\' '
    'AND {}'.format(db_schema,db_table,pathway,version,indicator))


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
    log.info('...write to sheet...')
    

def reeem_db_indicatorlist(log, writer, pathway, version, db_schema, db_table, file_name, con):
    """read database table and get list of all indicators"""
    
    # list of all indicators
    log.info('...execute SQL query:')
    sql_ind_list = text(
    'SELECT pathway,version,nid,field,category,indicator,count(value) AS indicator_count '
    'FROM model_draft.reeem_times_paneu_input '
    'WHERE pathway = \'{}\' '
    'AND version = \'{}\' '
    'GROUP BY pathway,version,nid,field,category,indicator '
    'ORDER BY pathway,version,nid'.format(pathway,version))
    print(sql_ind_list)
    
    df_indicator = pd.read_sql_query(sql_ind_list, con)
    # print (df_indicator)
    
    df_indicator.to_excel(writer,'list_of_indicator')
    log.info('...write to sheet...')
    

def reeem_db_2_excel(log, model, pathway, version, file_name, sql, con):
    """read database and write to excel file"""
    
    ## data
    # select data
    log.info('...execute SQL query:')
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
    log.info('...write data to sheet...')
    
    ## data_unstack
    # seperate columns
    log.info('...unstack data...')
    dfunit = df[['nid', 'pathway', 'version', 'region', 'field', 'category', 
    'indicator', 'unit', 'aggregation', 'updated', 'source']].copy().dropna()
    dfunit = dfunit.drop_duplicates(subset=['nid', 'pathway', 'version', 
    'region', 'unit', 'aggregation', 'source' ], keep='first')
    # dfunit.index.names = ['nid']
    # print(dfunit.head())
    # print(dfunit)
    
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
    dfxls = dfunstack.merge(dfunit, on='nid', how='left')
    # print(dfxls)
    
    dfxls.to_excel(writer,'data_unstack',startrow=4,index = False)
    log.info('...write data to sheet...')
    
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
    reeem_db_indicatorlist(log, writer, pathway, version, db_schema, db_table, file_name, con)
    reeem_db_2_excel(log, model, pathway, version, file_name, sql, con)
    
    # scenario log
    reeem_scenario_log(con, version, 'export', db_schema, db_table,
        os.path.basename(__file__), file_name)
    
    # write to file
    writer.save() 
    log.info('...write to file...')
    
    # close connection
    con.close()
    log.info('...script successfully executed in {:.2f} seconds...'
        .format(time.time() - start_time))
    log.info('...database connection closed. Goodbye!')
