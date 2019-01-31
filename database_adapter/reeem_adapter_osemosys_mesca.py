"""read data from file and write to database"""

__copyright__ = "© Reiner Lemoine Institut"
__license__ = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__ = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__ = "Ludwig Hülk"
__issue__ = "https://github.com/ReeemProject/reeem_db/issues/45"
__version__ = "v0.2.0"

from reeem_io import *

# input
filenames = [
            '2019-01-28_Pilot_OSeMOSYSMESCA_FrameworkNA_DataV1_Input.xlsx',
            '2019-01-28_Pilot_OSeMOSYSMESCA_FrameworkNA_DataV1_Output.xlsx']

# regions
# regions = ['EE']
regions = ['EE','FI','LT','LV']

empty_rows = 4

# database table
db_schema = 'model_draft'
db_table_input = 'reeem_osemosys_mesca_input'
db_table_output = 'reeem_osemosys_mesca_output'


def osemosys_mesca_2_reeem_db(filename, fns, db_table, empty_rows, db_schema,
                           region, con):
    """read excel file and sheets, make dataframe and write to database"""

    # read file
    path = os.path.join('Model_Data', 'OSeMOSYSMESCA', filename)
    xls = pd.ExcelFile(path)
    df = pd.read_excel(xls, region, header=empty_rows, index_col='ID')
    log.info('...read sheet: {}'.format(region))

    # make dataframe
    if fns['io'] == "Input":

        # label columns
        # df.columns = ['indicator', 'unit',
                    # '2015', '2020', '2025', '2030', '2035', 
                    # '2040', '2045', '2050', 'field', 'category', 
                    # 'aggregation', 'source']
        df.index.names = ['nid']
        # print(df.head())
    
        # seperate columns
        dfbase = df[['indicator', 'unit', 'field', 'category', 'aggregation', 'source'
                    ]].copy()
        dfbase.index.names = ['nid']
        # print(dfbase.head())
    
        # drop seperated columns
        dfclean = df.drop(
            ['indicator', 'unit', 'field', 'category', 'aggregation', 'source'],
            axis=1) #, 'source'
        # print(dfclean.head())
        
    else:
        
        # label columns
        # df.columns = ['indicator', 'unit',
        #             '2015', '2020', '2025', '2030', '2035', 
        #             '2040', '2045', '2050', 'field', 'category', 
        #             'aggregation']
        df.index.names = ['nid']
    
        # seperate columns
        dfbase = df[['indicator', 'unit', 'field', 'category', 'aggregation'
                    ]].copy()
        dfbase.index.names = ['nid']
        # dfbase.columns = ['category', 'indicator', 'unit', 'aggregation']
        # print(dfbase.head())
        
        # drop seperated columns
        dfclean = df.drop(
            ['indicator', 'unit', 'field', 'category', 'aggregation'],
            axis=1)
        # print(dfclean.head())

    # stack dataframe
    dfstack = dfclean.stack().reset_index()
    dfstack.columns = ['nid', 'year', 'value']
    # dfstack.set_index(['nid','year'], inplace=True)
    dfstack.index.names = ['id']
    # print(dfstack.head())

    # join dataframe for database
    dfdb = dfstack.join(dfbase, on='nid')
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
    
        # import
        for region in regions:
            osemosys_mesca_2_reeem_db(filename, fns, db_table, empty_rows,
                                db_schema, region, con)
    
        # scenario log
        scenario_log(con, 'REEEM', __version__, 'import', db_schema, db_table,
                    os.path.basename(__file__), filename)

    # close connection
    con.close()
    log.info('...script successfully executed in {:.2f} seconds...'
             .format(time.time() - start_time))
    log.info('...database connection closed. Goodbye!')
