"""read data from file and write to database"""

__copyright__ = "© Reiner Lemoine Institut"
__license__ = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__ = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__ = "Ludwig Hülk"
__issue__ = "https://github.com/ReeemProject/reeem_db/issues/13"
__version__ = "v0.1.3"

from reeem_io import *

# input
filenames = [
            # '2017-02-07_Test_OSEMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2018-09-10_Base_OSEMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2018-11-27_Base_OSeMBE_FrameworkNA_DataV1_Output.xlsx',

            # '2019-01-03_C0T0E0_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E1_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E2_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E3_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E4_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E5_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E6_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E7_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E8_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E9_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E10_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E11_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E12_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E13_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E14_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E15_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E16_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E17_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E18_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E19_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E20_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E21_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E22_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E23_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E24_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E25_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T0E26_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-07_C0T1E0_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-07_C0T1E1_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-07_C0T1E2_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-07_C0T1E3_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-07_C0T1E4_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-07_C0T1E5_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-07_C0T1E6_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-07_C0T1E7_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-07_C0T1E8_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-07_C0T1E9_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-07_C0T1E10_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-07_C0T1E11_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-07_C0T1E12_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-07_C0T1E13_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-07_C0T1E14_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-07_C0T1E15_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-07_C0T1E16_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T1E17_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T1E18_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T1E19_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T1E20_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T1E21_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T1E22_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T1E23_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T1E24_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T1E25_OSeMBE_FrameworkNA_DataV1_Output.xlsx',
            # '2019-01-03_C0T1E26_OSeMBE_FrameworkNA_DataV1_Output.xlsx']


# regions = ['EU28']
# regions = ['EU28', 'AT', 'BE', 'BG', 'CY', 'CZ', 'DE', 'DK', 'EE', 'ES',
#            'FI', 'FR', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LU', 'LV',
#            'MT', 'NL', 'PL', 'PT', 'RO', 'SE', 'SI', 'SK', 'UK']
# regions = ['EU30', 'AT', 'BE', 'BG', 'CH', 'CY', 'CZ', 'DE', 'DK', 'EE', 
#            'ES', 'FI', 'FR', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LU', 
#            'LV', 'MT', 'NL', 'NO', 'PL', 'PT', 'RO', 'SE', 'SI', 'SK', 
#            'UK']
regions = ['EU+CH+NO', 'AT', 'BE', 'BG', 'CH', 'CY', 'CZ', 'DE', 'DK', 'EE', 
           'ES', 'FI', 'FR', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LU', 
           'LV', 'MT', 'NL', 'NO', 'PL', 'PT', 'RO', 'SE', 'SI', 'SK', 
           'UK']

empty_rows = 5

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
                  '2045', '2046', '2047', '2048', '2049', '2050', 'category',
                  'aggregation']
    df.index.names = ['nid']
    # print(df.head())
    # print(df.dtypes)

    # seperate columns
    dfunit = df[['category', 'indicator', 'unit', 'aggregation']].copy().dropna()
    dfunit.index.names = ['nid']
    dfunit.columns = ['category', 'indicator', 'unit', 'aggregation']
    # print(dfunit.head())
    # print(dfunit.dtypes)

    # drop seperated columns
    dfclean = df.drop(['category', 'indicator', 'unit', 'aggregation'],
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
    
    # logging
    log = logger()
    start_time = time.time()
    log.info('script started...')
    
    # connection
    con = reeem_session()
    log.info('...read file(s)...')
    
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
