"""read data from file and write to database"""

__copyright__ = "© Reiner Lemoine Institut"
__license__ = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__ = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__ = "Ludwig Hülk"
__issue__ = "https://github.com/ReeemProject/reeem_db/issues/8"
__version__ = "v0.2.0"

from reeem_io import *

# input
filenames = ['2018-10-30_Base_EnergyPRO_FrameworkV1_DataV1_Input.xlsx', 
             '2018-10-30_Base_EnergyPRO_FrameworkV1_DataV1_Output.xlsx',
             '2018-10-30_Base_EnergyPRO_FrameworkV1_DataV2_Input.xlsx',
             '2018-10-30_Base_EnergyPRO_FrameworkV1_DataV2_Output.xlsx']


# regions
regions = ['PL-Warsaw', 'FI-Helsinki']

empty_rows = 4

# database table
db_schema = 'model_draft'
db_table_input = 'reeem_energypro_input'
db_table_output = 'reeem_energypro_output'


def energypro_2_reeem_db(filename, fns, db_table, empty_rows, db_schema,
                           region, con):
    """read excel file and sheets, make dataframe and write to database"""

    # read file
    path = os.path.join('Model_Data', 'EnergyPRO', filename)
    xls = pd.ExcelFile(path)
    df = pd.read_excel(xls, region, header=empty_rows, index_col='id')
    log.info('......read sheet: {}'.format(region))

    if fns['io'] == "Input":
        
        # make dataframe
        df.columns = ['field', 'category', 'indicator', 'unit',
                      '2020', '2030', '2050',
                      'source', 'aggregation']    
        df.index.names = ['nid']

        # seperate columns
        dfunit = df[['field', 'category', 'indicator', 'unit', 
                     'source', 'aggregation'
                    ]].copy()
        dfunit.index.names = ['nid']
        dfunit.columns = ['field', 'category', 'indicator', 'unit', 
                          'source', 'aggregation']

        # drop seperated columns
        dfclean = df.drop(
            ['field', 'category', 'indicator', 'unit', 'source', 'aggregation'],
            axis=1)
        
        # stack dataframe
        dfstack = dfclean.stack().reset_index()
        dfstack.columns = ['nid', 'year', 'value']
        dfstack.index.names = ['id']
                      
    else:
        # make dataframe
        df.columns = ['field', 'category', 'indicator', 'unit',
                      '2020-01', '2020-02', '2020-03', '2020-04', '2020-05', '2020-06',
                      '2020-07', '2020-08', '2020-09', '2020-10', '2020-11', '2020-12',
                      '2030-01', '2030-02', '2030-03', '2030-04', '2030-05', '2030-06', 
                      '2030-07', '2030-08', '2030-09', '2030-10', '2030-11', '2030-12', 
                      '2050-01', '2050-02', '2050-03', '2050-04', '2050-05', '2050-06',
                      '2050-07', '2050-08', '2050-09', '2050-10', '2050-11', '2050-12',
                      'aggregation']
        df.index.names = ['nid']
        
        # seperate columns
        dfunit = df[['field', 'category', 'indicator', 'unit', 
                     'aggregation'
                    ]].copy()
        dfunit.index.names = ['nid']
        dfunit.columns = ['field', 'category', 'indicator', 'unit', 
                          'aggregation']

        # drop seperated columns
        dfclean = df.drop(
            ['field', 'category', 'indicator', 'unit', 'aggregation'],
            axis=1)

        # stack dataframe
        dfstack = dfclean.stack().reset_index()
        dfstack.columns = ['nid', 'year_month', 'value']
        dfstack.index.names = ['id']
        df_ym = dfstack['year_month'].str.split('-', expand=True)
        df_ym.columns = ['year', 'month']
        dfstack['year'] = df_ym['year']
        dfstack['month'] = df_ym['month']
        

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
                index=True)
    log.info('......sheet {} sucessfully imported...'.format(region))


if __name__ == '__main__':
    
    # logging
    log = logger()
    start_time = time.time()
    log.info('script started...')
    
    # connection
    log.info('...establish database connection:')
    con = reeem_session()
    
    # import files
    for filename in filenames:
        
        # file and table
        fns = reeem_filenamesplit(filename)
    
        # i/o
        if fns['io'] == "Input":
            db_table = db_table_input
        else:
            db_table = db_table_output
    
        # log files
        log.info('read file: {}'.format(filename))
        log.info('...model: {}'.format(fns['model']))
        log.info('...pathway: {}'.format(fns['pathway']))
        log.info('...framework: {}'.format(fns['framework']))
        log.info('...version: {}'.format(fns['version']))
        log.info('...i/o: {}'.format(fns['io']))
        log.info('...regions: {}'.format(regions))
        log.info('...database table: model_draft.{}'.format(db_table))

        # import sheets
        for region in regions:
            energypro_2_reeem_db(filename, fns, db_table, empty_rows,
                                db_schema, region, con)

        # scenario log
        scenario_log(con, 'REEEM', __version__, 'import', db_schema, db_table,
                    os.path.basename(__file__), filename)


    # close connection
    con.close()
    log.info('script successfully executed in {:.2f} seconds...'
             .format(time.time() - start_time))
    log.info('database connection closed. Goodbye!')
