import sys
import getpass
import pandas as pd
from sqlalchemy import *


def reeem_session():
    """SQLAlchemy session object with valid connection to reeem database"""

    print('Please provide connection parameters to database:\n' +
          'Hit [Enter] to take defaults')
    host = '130.226.55.43'  # input('host (default 130.226.55.43): ')
    port = '5432'  # input('port (default 5432): ')
    database = 'reeem'  # input("database name (default 'reeem'): ")
    user = 'reeem_vis'  # input('user (default postgres): ')
    # password = input('password: ')
    password = getpass.getpass(prompt='password: ',
                               stream=sys.stderr)
    con = create_engine(
        'postgresql://' + '%s:%s@%s:%s/%s' % (user,
                                              password,
                                              host,
                                              port,
                                              database)).connect()
    print('Password correct! Database connection established.')
    return con


con = reeem_session()

# Number of entries in table
models = [
    # 'times_paneu_input',
    # 'times_paneu_output',
    # 'osembe_output',
    'plexos_input',
    'plexos_output',
    'energypro_input',
    'energypro_output',
    'ecosense_output',
    'ecosenseeva_output',
    'newage_output'
]

for model in models:
    sql = """
        SELECT (EACH(tags)).*,
                tags -> 'schema' AS schema,
                tags -> 'model' AS model,
                COUNT(*) AS amount
        FROM model_draft.reeem_{0}
        GROUP BY EACH(tags), tags -> 'schema', tags -> 'model'
    """.format(model)
    df = pd.read_sql_query(sql, con)
    df.index.name = 'id'
    df = df[df.key != 'model']
    df = df[df.key != 'schema']
    df.to_csv("{0}.csv".format(model), encoding='utf-8')
    print(df)
