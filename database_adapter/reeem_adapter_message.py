"""read data from file and write to database"""

__copyright__ = "© Reiner Lemoine Institut"
__license__ = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__ = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__ = "Ludwig Hülk"
__issue__ = "https://github.com/ReeemProject/reeem_db/issues/11"
__version__ = "v0.2.0"

from reeem_io import *

# input
filenames = [
    #'2019-01-28_Base_MESSAGE_FrameworkNA_DataV2_Output.xlsx',
    #'2019-01-28_Base_MESSAGE_FrameworkNA_DataV2_Input.xlsx',

    '2019-01-28_All_MESSAGE_FrameworkNA_DataV3_Input.xlsx',
    '2019-02-12_Base_MESSAGE_FrameworkNA_DataV3_Output.xlsx',
    '2019-02-12_CO2Lin_MESSAGE_FrameworkNA_DataV3_Output.xlsx',
    '2019-02-12_HighRES_MESSAGE_FrameworkNA_DataV3_Output.xlsx'
    ]

# regions
# regions = ['AT']
regions = ['FI','EE','LT','LV']

empty_rows = 4  # or 5

# database table
db_schema = 'model_draft'
db_table_input = 'reeem_message_input'
db_table_output = 'reeem_message_output'


def message_2_reeem_db(filename, fns, db_table, empty_rows, db_schema,
                           region, con):
    """read excel file and sheets, make dataframe and write to database"""

    # read file
    path = os.path.join('Model_Data', 'MESSAGE', filename)
    xls = pd.ExcelFile(path)
    df = pd.read_excel(xls, region, header=empty_rows, index_col='ID')
    log.info('...read sheet: {}'.format(region))

    # make dataframe
    if fns['io'] == "Input":

        # label columns
        df.columns = ['indicator', 'internal_id', 'unit',
                      '2006', '2007', '2008', '2009', '2010',
                      '2011', '2012', '2013', '2014', '2015',
                      '2016', '2017', '2018', '2019', '2020',
                      '2021', '2022', '2023', '2024', '2025',
                      '2026', '2027', '2028', '2029', '2030',
                      '2031', '2032', '2033', '2034', '2035',
                      '2036', '2037', '2038', '2039', '2040',
                      '2041', '2042', '2043', '2044', '2045',
                      '2046', '2047', '2048', '2049', '2050',
                      'field', 'category', 'aggregation', 'source']
        df.index.names = ['nid']

        # seperate columns
        dfunit = df[['category', 'indicator', 'internal_id', 'unit', 'aggregation', 'source'
                    ]].copy()
        dfunit.index.names = ['nid']
        # dfunit.columns = ['category', 'indicator', 'unit', 'aggregation']
        # print(dfunit.head())
    
        # drop seperated columns
        dfclean = df.drop(
            ['internal_id', 'field', 'category', 'indicator', 'unit', 'aggregation', 'source'],
            axis=1) #, 'source'
        # print(dfclean.head())
        
    else:
        
        # label columns
        df.columns = ['indicator', 'unit',
                    '2015', '2020', '2025', '2030', '2035', 
                    '2040', '2045', '2050', 'field', 'category', 
                    'aggregation']
        df.index.names = ['nid']
    
        # seperate columns
        dfunit = df[['category', 'indicator', 'unit', 'aggregation'
                    ]].copy()
        dfunit.index.names = ['nid']
        # dfunit.columns = ['category', 'indicator', 'unit', 'aggregation']
        # print(dfunit.head())
        
        # drop seperated columns
        dfclean = df.drop(
            ['field', 'category', 'indicator', 'unit', 'aggregation'],
            axis=1)
        # print(dfclean.head())

    # stack dataframe
    dfstack = dfclean.stack().reset_index()
    dfstack.columns = ['nid', 'year', 'value']
    # dfstack.set_index(['nid','year'], inplace=True)
    dfstack.index.names = ['id']
    # print(dfstack.head())

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
    
        # import
        for region in regions:
            message_2_reeem_db(filename, fns, db_table, empty_rows,
                                db_schema, region, con)
    
        # scenario log
        scenario_log(con, 'REEEM', __version__, 'import', db_schema, db_table,
                    os.path.basename(__file__), filename)

    # close connection
    con.close()
    log.info('...script successfully executed in {:.2f} seconds...'
             .format(time.time() - start_time))
    log.info('...database connection closed. Goodbye!')
