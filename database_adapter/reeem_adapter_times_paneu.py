"""read data from file and write to database"""

__copyright__ = "© Reiner Lemoine Institut"
__license__ = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__ = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__ = "Ludwig Hülk"
__issue__ = "https://github.com/ReeemProject/reeem_db/issues/4"
__version__ = "v0.2.0"

from reeem_io import *

# input
filenames = [
#              '2017-10-27_Pilot_TIMESPanEU_FrameworkV1_DataV1_Input.xlsx',
#              '2017-10-27_Pilot_TIMESPanEU_FrameworkV1_DataV1_Output.xlsx',
#
#              '2017-11-15_HighRES_TIMESPanEU_FrameworkV1_DataV1_Input.xlsx',
#              '2017-11-15_HighRES_TIMESPanEU_FrameworkV1_DataV1_Output.xlsx',
#
#              '2017-11-15_HighRES_TIMESPanEU_FrameworkV1_DataV2_Output.xlsx",  # MISSING!
#
#              '2018-07-10_HighRES_TIMESPanEU_FrameworkV1_DataV3_Output.xlsx',
#              '2018-07-10_HighRES_TIMESPanEU_FrameworkV2_DataV1_Output.xlsx',
#
#              '2017-11-15_StorageInnov_TIMESPanEU_FrameworkV1_DataV1_Input.xlsx',
#              '2017-11-15_StorageInnov_TIMESPanEU_FrameworkV1_DataV1_Output.xlsx',
#
#              '2017-11-15_Base_TIMESPanEU_FrameworkV1_DataV1_Input.xlsx',
#              '2017-11-15_Base_TIMESPanEU_FrameworkV1_DataV1_Output.xlsx',
#
#              '2018-01-16_Base_TIMESPanEU_FrameworkV1_DataV2_Input.xlsx',
#              '2018-01-16_Base_TIMESPanEU_FrameworkV1_DataV2_Output.xlsx',
#
#              '2018-07-10_Base_TIMESPanEU_FrameworkV2_DataV1_Input.xlsx',
#              '2018-07-10_Base_TIMESPanEU_FrameworkV2_DataV1_Output.xlsx',
#
#              '2018-08-01_Base_TIMESPanEU_FrameworkV1_DataV3_Input.xlsx',
#              '2018-07-19_Base_TIMESPanEU_FrameworkV1_DataV3_Output.xlsx'
#
#              '2018-12-20_Base_TIMESPanEU_FrameworkV1_DataV4_Input.xlsx',
#              '2018-12-20_Base_TIMESPanEU_FrameworkV1_DataV4_Output.xlsx',
#              '2018-12-20_Base_TIMESPanEU_FrameworkV2_DataV2_Output.xlsx',
#              '2018-12-20_HighRES_TIMESPanEU_FrameworkV1_DataV4_Output.xlsx',
#
#              '2019-02-07_LocalSolutions_TIMESPanEU_FrameworkV1_DataV1_Output.xlsx',
#
#              '2019-03-28_GHG_TIMESPanEU_FrameworkV3_DataV1_Output.xlsx',
#              '2019-04-17_Base_TIMESPanEU_FrameworkV3_DataV1_Output.xlsx',
#              '2019-05-02_LocalSolutions_TIMESPanEU_FrameworkV3_DataV2_Output.xlsx',
#
#    '2019-05-06_All Pathways_TIMESPanEU_Input.xlsx',  # Can't process, wrong naming
    '2019-05-20_LS_TIMESPanEU_FrameworkV3_DataV2_Output.xlsx',
    '2019-05-20_PA_TIMESPanEU_FrameworkV3_DataV1_Output.xlsx'
]

# regions
# regions = ['AT']
regions = ['EU28','AT','BE','BG','CH','CY','CZ','DE','DK','EE','ES',
            'FI','FR','GR','HR','HU','IE','IT','LT','LU','LV',
            'MT','NL','NO','PL','PT','RO','SE','SI','SK','UK']

empty_rows = 4

# database table
db_schema = 'model_draft'
db_table_input = 'reeem_times_paneu_input'
db_table_output = 'reeem_times_paneu_output'


def times_paneu_2_reeem_db(filename, fns, db_table, empty_rows, db_schema,
                           region, con):
    """read excel file and sheets, make dataframe and write to database"""

    # read file
    path = os.path.join('Model_Data', 'TIMESPanEU', filename)
    xls = pd.ExcelFile(path)
    df = pd.read_excel(xls, region, header=empty_rows, index_col='ID')
    log.info('...read sheet: {}'.format(region))

    # make dataframe
    if fns['io'] == "Input":

        # label columns
        df.columns = ['indicator', 'unit',
                    '2015', '2020', '2025', '2030', '2035', 
                    '2040', '2045', '2050', 'field', 'category', 
                    'aggregation', 'source']
        df.index.names = ['nid']
    
        # seperate columns
        dfunit = df[['category', 'indicator', 'unit', 'aggregation', 'source'
                    ]].copy()
        dfunit.index.names = ['nid']
        # dfunit.columns = ['category', 'indicator', 'unit', 'aggregation']
        # print(dfunit.head())
    
        # drop seperated columns
        dfclean = df.drop(
            ['field', 'category', 'indicator', 'unit', 'aggregation', 'source'],
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
            times_paneu_2_reeem_db(filename, fns, db_table, empty_rows,
                                db_schema, region, con)
    
        # scenario log
        scenario_log(con, 'REEEM', __version__, 'import', db_schema, db_table,
                    os.path.basename(__file__), filename)

    # close connection
    con.close()
    log.info('...script successfully executed in {:.2f} seconds...'
             .format(time.time() - start_time))
    log.info('...database connection closed. Goodbye!')
