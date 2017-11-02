"""open a database connection to reeem_db"""

__copyright__ 	= "© Reiner Lemoine Institut"
__license__ 	= "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__ 		= "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__ 		= "Ludwig Hülk"

from sqlalchemy import *
import getpass
import sys

# manage password in keyring
# un = 'user_name'
# pw = 'test'
# keyring.set_password('reeem', un, pw) # only set pw once!
# print(un +' : ' +  keyring.get_password('reeem', un))


def reeem_session():
    """SQLAlchemy session object with valid connection to reeem database"""
    print('Please provide connection parameters to database:\n' +
            'Hit [Enter] to take defaults')

    #host = input('host (default 130.226.55.43): ')
    host = '130.226.55.43'
    #port = input('port (default 5432): ')
    port = '5432'
    #database = input("database name (default 'reeem'): ")
    database = 'reeem'
    user = input('user (default test_user): ')
    # password = input('password: ')
    password = getpass.getpass(prompt='password: ',
                                stream=sys.stderr)
    con = create_engine(
        'postgresql://' + '%s:%s@%s:%s/%s' % (user,
                                                password,
                                                host,
                                                port,
                                                database)).connect()

    return con
    logger.info('...database connection activated...')
    

# # test connection and return username
# con = reeem_session(section='reeem')
# # select columns 
# sql = text('SELECT name FROM test.table')
# table = con.execute(sql.execution_options(autocommit=True))
# for row in table:
#     print("username:", row['name'])
# # select session user
# sql = text('SELECT session_user')
# username = con.execute(sql.execution_options(autocommit=True))
# row = username.fetchone()
# print(row['session_user'])
# con.close()


def reeem_scenario_log(con,version,io,schema,table,script,comment):
    """
    write entry in scenario log table
    Parameters
    ----------
    con : SQLAlchemy connection object
    version: str
        Version number
    io: str
        IO-type (input, output, temp)
    schema : str
        Database schema
    table : str
        Database table
    script : str
        Script name
    comment : str
        Comment

    Returns
    -------
    None
    """
    sql=text("""
    INSERT INTO model_draft.reeem_scenario_log
        (version,io,schema_name,table_name,script_name,entries,comment,
        user_name,timestamp,metadata)
    SELECT	'{0}' AS version,
            '{1}' AS io,
            '{2}' AS schema_name,
            '{3}' AS table_name,
            '{4}' AS script_name,
            COUNT(*)AS entries,
            '{5}' AS comment,
            session_user AS user_name,
            NOW() AT TIME ZONE 'Europe/Berlin' AS timestamp,
            obj_description('{2}.{3}' ::regclass) ::json AS metadata
    FROM	{2}.{3};""".format(version,io,schema,table,script,comment))
    con.execute(sql)
