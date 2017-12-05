"""read data from database and write to file"""

__copyright__   = "Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__license_url__ = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/23"
__version__     = "v0.1.2"

import os.path
import time
import datetime
import pandas as pd
from sqlalchemy import *
from reeem_io import *

# parameter
model = 'UCL Model'
pathway = 'Test_data'   # 'BASE', 'BASE_TI1_P1', 'BASE_TI1_P2', 'Test_data'
version = 'V1'  # 'V2', 'V3'

file_name = 'REEEM_db_output_ucl.xlsx'

regions = ['AT']
# regions = ['EU28', 'AT', 'BE', 'BG', 'CY', 'CZ', 'DE', 'DK', 'EE', 'ES', 
#     'FI', 'FR', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LU', 'LV', 
#     'MT', 'NL', 'PL', 'PT', 'RO', 'SE', 'SI', 'SK', 'UK']

db_schema = 'model_draft'
db_table = 'reeem_times_paneu_input'
indicator = '(nid = \'70\' OR nid = \'63\')'
sql = text("SELECT * FROM {}.{} "
           "WHERE pathway = '{}' "
           "AND version = '{}' "
           "AND {} ".format(db_schema, db_table, pathway, version, indicator))
# todo: make indicator a list and use loop to create sql!

# functions
def reeem_db_pathway(con, log, excel):
    """read database pathway and write to excel sheet

    Parameters
    ----------
    con : SQLAlchemy object
        Database connection object.
    log : function
        Logger.
    excel : ExcelWriter object
        Output Excel file.
    """

    log.info('...select from pathway table...')
    sql_pathway = 'SELECT * FROM model_draft.reeem_pathway'

    df_pathway = pd.read_sql_query(sql_pathway, con).loc[:, ['id', 'pathway']]
    # print (df_pathway)

    df_pathway.to_excel(excel, 'pathways')
    log.info('......write to sheet...')


def reeem_db_indicatorlist(con, log, excel):
    """Read database table and get list of all indicators

    Parameters
    ----------
    con : SQLAlchemy object
        Database connection object.
    log : function
        Logger.
    excel : ExcelWriter object
        Output Excel file.
    """

    log.info('...select all indicators...')
    sql_ind_list = text(
        'SELECT pathway,version,nid,field,category,indicator,count(value) AS indicator_count '
        'FROM model_draft.reeem_times_paneu_input '
        'WHERE pathway = \'{}\' '
        'AND version = \'{}\' '
        'GROUP BY pathway,version,nid,field,category,indicator '
        'ORDER BY pathway,version,nid'.format(pathway, version))
    print(sql_ind_list)

    df_indicator = pd.read_sql_query(sql_ind_list, con)
    # print (df_indicator)

    df_indicator.to_excel(excel, 'list_of_indicator')
    log.info('......write to sheet...')


def reeem_db_2_excel(con, log, excel, sql):
    """Read database and write to excel file.

    Parameters
    ----------
    con : SQLAlchemy object
        Database connection object.
    log : function
        Logger.
    excel : ExcelWriter object
        Output Excel file.
    """

    ## data : db format
    # select data
    log.info('...execute SQL query:')
    print(sql)

    df = pd.read_sql_query(sql, con)
    # print (df)

    df.to_excel(excel, 'data', startrow=4, index=False)

    # add header
    today = datetime.date.today()
    header_data = [pathway, version, today.isoformat()]
    header_columns = ['pathway', 'version', 'date']
    df_header = pd.DataFrame(data=header_data).T
    df_header.columns = header_columns
    # print(df_header.T)

    df_header.to_excel(excel, 'data', index=False)
    log.info('...write data to sheet...')

    ## data : unstack format
    # seperate columns
    log.info('...unstack data...')
    dfunit = df[['nid', 'pathway', 'version', 'region', 'field', 'category',
                 'indicator', 'unit', 'aggregation', 'updated',
                 'source']].copy().dropna()
    dfunit = dfunit.drop_duplicates(subset={'nid', 'pathway', 'version',
                                            'region', 'unit', 'aggregation',
                                            'source'}, keep='first')
    # dfunit.index.names = ['nid']
    # print(dfunit.head())
    # print(dfunit)

    # drop seperated columns
    dfclean = df.drop(
        ['id', 'dfid', 'pathway', 'version', 'region', 'field', 'category',
         'indicator', 'unit', 'aggregation', 'updated', 'source'],
        axis=1).dropna()
    # print(dfclean.head())
    # print(dfclean)

    # unstack dataframe
    # dfunstack = dfclean.reset_index().pivot(columns='year', index='nid',
    # values='value')
    dfunstack = dfclean.reset_index().pivot(columns='year', index='nid',
                                            values='value').reset_index()
    # print(dfunstack)

    # join dataframe with units
    # dfxls = dfunstack.join(dfunit, on='nid')
    dfxls = dfunstack.merge(dfunit, on='nid', how='left')
    # print(dfxls)

    dfxls.to_excel(excel, 'data_unstack', startrow=4, index=False)
    log.info('...write data to sheet...')

    # add header
    today = datetime.date.today()
    header_data = [pathway, version, today.isoformat()]
    df_header = pd.DataFrame(data=header_data).T
    df_header.columns = ['pathway', 'version', 'date']
    # print(df_header.T)

    df_header.to_excel(excel, 'data_unstack', index=False)


if __name__ == '__main__':
    # logging
    logger = logger()
    start_time = time.time()
    logger.info('script started...')
    logger.info('...pathway: {}'.format(pathway))
    logger.info('...model: {}'.format(model))
    logger.info('...version: {}'.format(version))
    logger.info('...establish database connection...')

    # connection
    conn = reeem_session()

    # output file path
    data_path = os.path.join('Model_Data', pathway, model, file_name)
    writer = pd.ExcelWriter(data_path)

    # sql
    reeem_db_pathway(conn, logger, writer)
    reeem_db_indicatorlist(conn, logger, writer)
    reeem_db_2_excel(conn, logger, writer, sql)

    # scenario log
    reeem_scenario_log(conn, version, 'export', db_schema, db_table,
                       os.path.basename(__file__), file_name)

    # write to file
    writer.save()
    logger.info('...write to file...')

    # close connection
    conn.close()
    logger.info('...script successfully executed in {:.2f} seconds...'.format(
        time.time() - start_time))
    logger.info('...database connection closed. Goodbye!')
