"""read data from file and write to database"""

__copyright__ = "© Reiner Lemoine Institut"
__license__ = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__ = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__ = "Ludwig Hülk"
__issue__ = "https://github.com/ReeemProject/reeem_db/issues/13"
__version__ = "v0.1.3"

from reeem_io import *

# input
# filename = "2017-02-07_Test_OSEMBE_FrameworkNA_DataV1_Output.xlsx"
filename = "2018-09-10_Base_OSEMBE_FrameworkNA_DataV1_Output.xlsx"

# regions = ['EU28']
# regions = ['EU28', 'AT', 'BE', 'BG', 'CY', 'CZ', 'DE', 'DK', 'EE', 'ES',
#            'FI', 'FR', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LU', 'LV',
#            'MT', 'NL', 'PL', 'PT', 'RO', 'SE', 'SI', 'SK', 'UK']
regions = ['EU28', 'AT', 'BE', 'BG', 'CH', 'CY', 'CZ', 'DE', 'DK', 'EE', 
           'ES', 'FI', 'FR', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LU', 
           'LV', 'MT', 'NL', 'NO', 'PL', 'PT', 'RO', 'SE', 'SI', 'SK', 
           'UK']

empty_rows = 4

# database table
db_schema = 'model_draft'
db_table_input = 'reeem_osembe_input'
db_table_output = 'reeem_osembe_output'


def osembe_2_reeem_db(filename, fns, empty_rows, db_schema, region, con):
    """read excel file and sheets, make dataframe and write to database"""

    # read file
    path = os.path.join('Model_Data', 'OSeMBE', filename)
    xls = pd.ExcelFile(path)
    df = pd.read_excel(xls, region, header=empty_rows, index_col='ID')
    log.info('...read sheet: {}'.format(region))

    # make dataframe
    df.columns = ['indicator', 'unit',
                  '2015', '2016', '2017', '2018', '2019', '2020', '2021',
                  '2022', '2023', '2024',
                  '2025', '2026', '2027', '2028', '2029', '2030', '2031',
                  '2032', '2033', '2034',
                  '2035', '2036', '2037', '2038', '2039', '2040', '2041',
                  '2042', '2043', '2044',
                  '2045', '2046', '2047', '2048', '2049', '2050', '2051',
                  '2052', '2053', '2054',
                  '2055', 'field', 'aggregation']
    df.index.names = ['nid']
    # print(df.head())
    # print(df.dtypes)

    # seperate columns
    dfunit = df[['field', 'indicator', 'unit', 'aggregation']].copy().dropna()
    dfunit.index.names = ['nid']
    dfunit.columns = ['field', 'indicator', 'unit', 'aggregation']
    # print(dfunit.head())
    # print(dfunit.dtypes)

    # drop seperated columns
    dfclean = df.drop(['field', 'indicator', 'unit', 'aggregation', 
                       '2051', '2052', '2053', '2054', '2055'],
                      axis=1).dropna()
    # print(dfclean.head())
    # print(dfclean)

    # stack dataframe
    dfstack = dfclean.stack().reset_index()
    dfstack.columns = ['nid', 'year', 'value']
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
    # dfdb['updated'] = (datetime.datetime.fromtimestamp(time.time())
    #     .strftime('%Y-%m-%d %H:%M:%S'))
    # print(dfdb.head())

    # copy dataframe to database
    dfdb.to_sql(con=con,
                schema=db_schema,
                name=db_table,
                if_exists='append',
                index=True)
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
    fns = reeem_filenamesplit(filename)
    log.info('...pathway: {}'.format(fns['pathway']))
    log.info('...model: {}'.format(fns['model']))
    log.info('...framework: {}'.format(fns['framework']))
    log.info('...version: {}'.format(fns['version']))
    log.info('...i/o: {}'.format(fns['io']))
    log.info('...regions: {}'.format(regions))
    log.info('...establish database connection...')

    # connection
    con = reeem_session()
    log.info('...read file(s)...')

    # import
    for region in regions:
        osembe_2_reeem_db(filename, fns, empty_rows,
                         db_schema, region, con)

    # scenario log
    scenario_log(con, 'REEEM', __version__, 'import', db_schema, db_table,
                 os.path.basename(__file__), filename)

    # close connection
    con.close()
    log.info('...script successfully executed in {:.2f} seconds...'
             .format(time.time() - start_time))
    log.info('...database connection closed. Goodbye!')
