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
tables = [
    {'reeem_energypro_input': 'DataV1'},
    {'reeem_energypro_output': 'DataV1'},
]

for table in tables:
    for io_model, data_version in table.items():
        sql = """
            SELECT tags -> 'model' AS value_name, count(*) AS amount FROM model_draft.{0}
            WHERE version LIKE '{1}'
            GROUP BY value_name
            UNION ALL
            SELECT tags -> 'schema' AS value_name, count(*) AS amount FROM model_draft.{0}
            WHERE version LIKE '{1}'
            GROUP BY value_name
            UNION ALL
            SELECT tags -> 'field' AS value_name, count(*) AS amount FROM model_draft.{0}
            WHERE version LIKE '{1}'
            GROUP BY value_name
            UNION ALL
            SELECT tags -> 'category' AS value_name, count(*) AS amount FROM model_draft.{0}
            WHERE version LIKE '{1}'
            GROUP BY value_name""".format(io_model, data_version)
        df = pd.read_sql_query(sql, con)
        df.index.name = 'id'
        df.to_csv("{}_{}.csv".format(io_model, data_version), encoding='utf-8')
        print(df)
