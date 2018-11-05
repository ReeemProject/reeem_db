"""read data from file and write to database"""

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/14"
__version__     = "v0.1.3"

from reeem_io import *

# input
filename = "2018-04-25_Base_Plexos_FrameworkV1_DataV2_Output.xlsx"
# filename = "2018-04-25_Base_Plexos_FrameworkV1_DataV2_Input.xlsx"
# filename = "2018-02-02_Base_Plexos_FrameworkV1_DataV1_Output.xlsx"
# filename = "2018-02-02_Base_Plexos_FrameworkV1_DataV1_Input.xlsx"

# regions = ['BG']
regions = ['BG', 'HR', 'HU', 'RO', 'SI']

empty_rows = 4

# database table
db_schema = 'model_draft'
db_table_input = 'reeem_plexos_input'
db_table_output = 'reeem_plexos_output'


def plexos_2_reeem_db(filename, fns, db_table, empty_rows, db_schema,
                           region, con):
    """read excel file and sheets, make dataframe and write to database"""
    
    # read file
    path = os.path.join('Model_Data', fns['model'], filename)
    xls = pd.ExcelFile(path)
    df = pd.read_excel(xls, region, header=empty_rows, index_col='ID')
    log.info('...read sheet: {}'.format(region))
    
    # make dataframe
    if fns['io'] == "Input":
        df.columns = ['indicator', 'unit', '2030',
            'schema', 'field', 'category', 'aggregation', 'source']
        df.index.names = ['nid']
        # print(df.dtypes)
        # print(df.head())
        
        # seperate columns
        dfunit = df[['schema', 'field', 'category', 'indicator', 'unit', 
            'aggregation', 'source']].copy()
        dfunit.index.names = ['nid']
        dfunit.columns = ['schema', 'field', 'category', 'indicator', 'unit', 
            'aggregation', 'source']
        # print(df.dtypes)
        # print(df.head())
        
        # drop seperated columns
        dfclean = df.drop(['schema', 'field', 'category', 
            'indicator', 'unit', 'aggregation', 'source'],axis=1)
        # print(dfclean)
    
    else:
        df.columns = ['indicator', 'unit', '2030',
            'schema', 'field', 'category', 'aggregation']
        df.index.names = ['nid']
        # print(df.dtypes)
        # print(df.head())
        
        # seperate columns
        dfunit = df[['schema', 'field', 'category', 
            'indicator', 'unit', 'aggregation']].copy()
        dfunit.index.names = ['nid']
        dfunit.columns = ['schema', 'field', 'category', 
            'indicator', 'unit', 'aggregation']
        # print(df.dtypes)
        # print(df.head())
        
        # drop seperated columns
        dfclean = df.drop(['schema', 'field', 'category', 
            'indicator', 'unit', 'aggregation'],axis=1)
        # print(dfclean)
    
    # stack dataframe
    dfstack = dfclean.stack().reset_index()
    dfstack.columns = ['nid','year','value']
    # dfstack.set_index(['nid','year'], inplace=True)
    dfstack.index.names = ['id']
    # print(dfstack)

    # join dataframe for database
    dfdb = dfstack.join(dfunit, on='nid')
    dfdb.index.names = ['dfid']
    dfdb['pathway'] = fns['pathway']
    dfdb['framework'] = fns['framework']
    dfdb['version'] = fns['version']
    dfdb['region'] = region
    dfdb['updated'] = fns['day']
    # (datetime.datetime.fromtimestamp(time.time())
    # .strftime('%Y-%m-%d %H:%M:%S'))
    # print(dfdb)
    
    # copy dataframe to database
    dfdb.to_sql(con=con, 
                schema=db_schema,
                name=db_table, 
                if_exists='append',
                index=True )
    log.info('......sheet {} sucessfully imported...'.format(region))


def plexos_output_2_reeem_db(model, pathway, version, file_name, empty_rows, db_schema, db_table, region, con):
    """read excel file and sheets, make dataframe and write to database"""
    
    log = logger()
    
    ## read file
    path = os.path.join('Model_Data', pathway, model, file_name)
    xls = pd.ExcelFile(path)
    df = pd.read_excel(xls, region, header=empty_rows, index_col='ID')
    log.info('...read sheet: {}'.format(region))
    
    ## make dataframe
    df.columns = ['indicator', 'unit', 
        '2030',
        'schema', 'field', 'category', 'aggregation']
    df.index.names = ['nid']
    # print(df.dtypes)
    # print(df.head())
    
    ## seperate columns
    dfunit = df[['schema', 'field', 'category', 
        'indicator', 'unit', 'aggregation']].copy().dropna()
    dfunit.index.names = ['nid']
    dfunit.columns = ['schema', 'field', 'category', 
        'indicator', 'unit', 'aggregation']
    # print(dfunit)
    # print(dfunit.dtypes)
    
    ## drop seperated columns
    dfclean = df.drop(['schema', 'field', 'category', 
        'indicator', 'unit', 'aggregation'],axis=1).dropna()
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
        if_exists = 'append',
        index = True )
    log.info('......sheet {} sucessfully imported...'.format(region))


if __name__ == '__main__':
    # file and table
    fns = reeem_filenamesplit(filename)

    # i/o
    if fns['io'] == "Input":
        db_table = db_table_input
    else:
        db_table = db_table_output
    
    # logging
    log = logger()
    start_time = time.time()
    log.info('script started...')
    log.info('...file: {}'.format(filename))
    log.info('...pathway: {}'.format(fns['pathway']))
    log.info('...model: {}'.format(fns['model']))
    log.info('...framework: {}'.format(fns['framework']))
    log.info('...version: {}'.format(fns['version']))
    log.info('...i/o: {}'.format(fns['io']))
    log.info('...regions: {}'.format(regions))
    log.info('...database table: model_draft.{}'.format(db_table))
    log.info('...establish database connection...')
    
    # connection
    con = reeem_session()
    log.info('...read file(s)...')
    
    # import
    for region in regions:
        plexos_2_reeem_db(filename, fns, db_table, empty_rows,
                          db_schema, region, con)
    
    # scenario log
    scenario_log(con, 'REEEM', __version__, 'import', db_schema, db_table,
                 os.path.basename(__file__), filename)

    # close connection
    con.close()
    log.info('...script successfully executed in {:.2f} seconds...'
             .format(time.time() - start_time))
    log.info('...database connection closed. Goodbye!')
