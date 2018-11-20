"""read data from file and write to database"""

__copyright__ = "© Reiner Lemoine Institut"
__license__ = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__ = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__ = "Ludwig Hülk"
__issue__ = "https://github.com/ReeemProject/reeem_db/issues/9"
__version__ = "v0.2.0"

from reeem_io import *

# input
filenames = ['2018-06-14_BASE_LEcA_FrameworkV2_DataV2_Output.csv']

empty_rows = 1

# database table
db_schema = 'model_draft'
db_table_input = 'reeem_leca_input' 
db_table_output = 'reeem_leca_output'


def leca_2_reeem_db(filename, fns, db_table, empty_rows, db_schema, con):
    """read csv file, make dataframe and write to database"""

    # read file
    csv = os.path.join('Model_Data', 'LeCA', filename)
    df = pd.read_csv(csv, sep=';', index_col='rid', encoding='utf-8')
        # ,nrows = 100 
    
                     # dtype={"2011": Decimal,"2015": Decimal,
                     #        "2020": Decimal,"2025": Decimal,
                     #        "2030": Decimal,"2035": Decimal,
                     #        "2040": Decimal,"2045": Decimal,
                     #        "2050": Decimal})

    # make dataframe
    # df.columns = ['nid', 'scenario', 'region', 'field', 'category', 'indicator', 'unit', 
    #               '2011', '2015', '2020', '2025', '2030', '2035',
    #               '2040', '2045', '2050']
    # df.set_index('nid').reset_index()
    # print(df.head())
    # print(df.dtypes)
    
    # seperate columns
    # dfunit = df[['scenario', 'region', 'category', 'field', 
    #              'indicator', 'unit', 'aggregation']].copy()
    # dfunit.index.names = ['id']
    # dfunit.columns = ['nid', 'scenario', 'region', 'field', 'category', 
    #                   'indicator', 'unit']
    # print(dfunit.head())

    # drop seperated columns
    # dfclean = df.drop(
    #     ['scenario', 'region', 'field', 'category', 'indicator', 'unit', 'aggregation'],
    #     axis=1)
    # print(dfclean.head())

    # stack dataframe
    # dfstack = dfclean.stack().reset_index()
    # dfstack.columns = ['rid', 'year', 'value']
    # dfstack.set_index(['nid','year'], inplace=True)
    # dfstack.index.names = ['id']
    # print(dfstack.head())

    # join dataframe for database
    # dfdb = dfstack.join(dfunit, on='rid')
    # dfdb.index.names = ['id']
    dfdb = df
    # dfdb.index.names = ['id']
    dfdb['pathway'] = fns['pathway']
    dfdb['framework'] = fns['framework']
    dfdb['version'] = fns['version']
    # dfdb['region'] = region
    dfdb['updated'] = fns['day']
    # (datetime.datetime.fromtimestamp(time.time())
    # .strftime('%Y-%m-%d %H:%M:%S'))
    # print(dfdb.head())
    
    # copy dataframe to database
    dfdb.to_sql(con=con,
                schema=db_schema,
                name=db_table,
                if_exists='append',
                index=True)
    log.info('......file {} sucessfully imported...'.format(filename))


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
    
        # i/o (only output)
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
        # log.info('...regions: {}'.format(regions))
        log.info('...database table: model_draft.{}'.format(db_table))
        
        # import sheets
        leca_2_reeem_db(filename, fns, db_table, empty_rows, db_schema, con)
    
        # scenario log
        scenario_log(con, 'REEEM', __version__, 'import', db_schema, db_table,
                    os.path.basename(__file__), filename)


    # close connection
    con.close()
    log.info('...script successfully executed in {:.2f} seconds...'
             .format(time.time() - start_time))
    log.info('...database connection closed. Goodbye!')
