"""read data from file and write to database"""

__copyright__ = "© Reiner Lemoine Institut"
__license__ = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__ = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__ = "Ludwig Hülk"
__issue__ = "https://github.com/ReeemProject/reeem_db/issues/32"
__version__ = "v0.2.0"

from reeem_io import *

# input
filename = "2018-05-16_PathwayNA_EcoSenseEVA_FrameworkV2_DataV1_Output.csv"

empty_rows = 1

# database table
db_schema = 'model_draft' 
db_table_input = 'reeem_ecosenseeva_input' 
db_table_output = 'reeem_ecosenseeva_output'


def ecosense_2_reeem_db(filename, fns, db_table, empty_rows, db_schema, con):
    """read csv file, make dataframe and write to database"""

    # read file
    csv = os.path.join('Model_Data', 'EcoSenseEVA', filename)
    df = pd.read_csv(csv, sep=';')

    # make dataframe
    df.columns = ['nid', 'category', 'region', 'year', 'indicator', 'value',
                  'unit', 'source', 'TIMES_commodity']
    df.index.names = ['id']
    dfdb = df.drop(
        ['source', 'TIMES_commodity'],
        axis=1).dropna()


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
    log.info('......table sucessfully imported...')


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
    #log.info('...regions: {}'.format(regions))
    log.info('...database table: model_draft.{}'.format(db_table))
    log.info('...establish database connection...')

    # connection
    con = reeem_session()
    log.info('...read file(s)...')

    # import
    ecosense_2_reeem_db(filename, fns, db_table, empty_rows, db_schema, con)

    # scenario log
    scenario_log(con, 'REEEM', __version__, 'import', db_schema, db_table,
                 os.path.basename(__file__), filename)

    # close connection
    con.close()
    log.info('...script successfully executed in {:.2f} seconds...'
             .format(time.time() - start_time))
    log.info('...database connection closed. Goodbye!')