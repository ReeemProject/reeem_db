"""read data from file and write to database"""

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__version__     = "v0.1.0"

from reeem_io import *

if __name__ == '__main__':
    
    log = logger()
    log.info('Script started...')
    log.info('...establish database connection...')
    con = reeem_session()
    
    # select pathways example
    log.info('...execute SQL...')
    sql = text('SELECT * FROM model_draft.reeem_pathway')
    print(sql)
    
    df = pd.read_sql_query(sql, con).loc[:,['id', 'pathway']]
    print (df)
    
    # result = con.execute(sql)
    # print (result)
    
    # table = []
    # for row in result:
    #     table.append(row[2])
    # print (table)

    con.close()
    log.info('...database connection closed. Goodbye!')
    