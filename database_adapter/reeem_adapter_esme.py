"""read data from file and write to database"""

__copyright__ = "© Reiner Lemoine Institut"
__license__ = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__ = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__ = "Ludwig Hülk"
__issue__ = "https://github.com/ReeemProject/reeem_db/issues/40"
__version__ = "v0.2.0"

from reeem_io import *

# input
filenames = ['2019-01-09_PathwayNA_ESME_FrameworkV1_DataV3_Output.xlsx']

empty_rows = 0

# database table
db_schema = 'model_draft' 
db_table_input = 'reeem_esme_input' 
db_table_output = 'reeem_esme_output'


def esme_2_reeem_db(filename, fns, db_table, empty_rows, db_schema, con):
    """read excel file, make dataframe and write to database"""

    # read file
    path = os.path.join('Model_Data', 'ESME', filename)
    xls = pd.ExcelFile(path)
    df = pd.read_excel(xls, 'Metrics', header=empty_rows, index_col='ID')
    log.info('...read sheet: {}'.format(fns['model']))
    dfcat = pd.read_excel(xls, 'Cat', header=empty_rows, index_col='indicator')
    log.info('...read sheet: Categorisation')

    # make dataframe
    #df.columns = ['nid', 'category', 'region', 'year', 'indicator', 'value',
    #              'unit', 'source', 'TIMES_commodity']
    df.index.names = ['nid']
    # print(df.head())
    # print(df.dtypes)

    # seperate base
    dfbase = df[['scenario', 'year']].copy()
    # print(dfbase.head())
    # print(dfbase)
    
    # seperate data
    dfdata = df.copy().drop(['scenario', 'year'], axis=1)
    dfdata.index.names = ['nid']
    # print(dfdata.head())
    # print(dfdata.dtypes)
    
    # stack dataframe
    dfstack = dfdata.stack().reset_index()
    dfstack.columns = ['nid', 'indicator', 'value']
    # dfstack.set_index(['nid','year'], inplace=True)
    dfstack.index.names = ['id']
    # print(dfstack.head())
    
    
    # join dataframe for database
    dfd = dfstack.join(dfbase, on='nid')
    dfd.index.names = ['dfid']
    # print(dfd.head())

    dfdb = dfd.join(dfcat, on='indicator')
    dfdb.index.names = ['dfid']
    print(dfdb.head())

    dfdb['pathway'] = fns['pathway']
    dfdb['framework'] = fns['framework']
    dfdb['version'] = fns['version']
    dfdb['updated'] = fns['day']
    dfdb['aggregation'] = True

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
        
        # import 
        esme_2_reeem_db(filename, fns, db_table, empty_rows, db_schema, con)
        
        # scenario log
        scenario_log(con, 'REEEM', __version__, 'import', db_schema, db_table,
                    os.path.basename(__file__), filename)


    # close connection
    con.close()
    log.info('...script successfully executed in {:.2f} seconds...'
             .format(time.time() - start_time))
    log.info('...database connection closed. Goodbye!')
