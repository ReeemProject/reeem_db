# -*- coding: utf-8 -*-

"""
Test database connection and reeem_io functions

This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
It's copyrighted by the contributors recorded in the version control history:
ReeemProject/reeem_db/database_adapter/reeem_io_test.py

SPDX-License-Identifier: AGPL-3.0-or-later
"""

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__license_url__ = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__version__     = "v0.1.3"

from reeem_io import *


def reeem_db_test_pathway(con, log):
    """Select the pathways from the reeem database."""

    # select from pathway table
    log.info('...select from pathway table...')
    sql_pathway = 'SELECT * FROM model_draft.reeem_pathway'
    # print(sql_pathway)

    # table to dataframe
    log.info('......print pathways...')
    df = pd.read_sql_query(sql_pathway, con).loc[:, ['id', 'pathway']]
    print(df)

    # result = con.execute(sql)
    # print (result)
    # table = []
    # for row in result:
    #     table.append(row[2])
    # print (table)


def reeem_db_test_scenario_log(con, log):
    """Add an test entry to the scenario log and return that line."""

    # test parameter
    log.info('...test scenario log function...')
    version = 'test'  # 'V1', 'V2', 'V3'
    db_schema = 'model_draft'
    db_table = 'reeem_pathway'
    comment = 'test'
    reeem_scenario_log(con, version, 'test', db_schema, db_table,
                       os.path.basename(__file__), comment)

    # select last entry
    log.info('......last entry in log function:')
    sql_scenariolog = text('SELECT * '
                           'FROM model_draft.reeem_scenario_log '
                           'ORDER BY id DESC LIMIT 1')
    df = pd.read_sql_query(sql_scenariolog, con)
    print(df)


if __name__ == '__main__':
    # logging
    log = logger()
    log.info('Script started...')
    log.info('...establish database connection...')

    # connection
    conn = reeem_session()
    time.sleep(1)

    # test connection and return username
    # get_db_username(con, log)

    # Test latest Scenario Log entry
    get_latest_scenariolog(conn, log)

    # select pathways example
    # reeem_db_test_pathway(conn, logger)

    # scenario log test
    # reeem_db_test_scenario_log(conn, logger)

    # close connection
    time.sleep(1)
    conn.close()
    log.info('...database connection closed. Goodbye!')
