"""open a database connection to reeem_db"""

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__version__     = "v0.1.0"

import sys
import os
import os.path as path
import numpy as np
import pandas as pd

import getpass
import logging
import time
import datetime

from sqlalchemy import *
import configparser as cp


sys.tracebacklimit = 0
cfg = cp.RawConfigParser()
configfile = 'reeem_io_config.ini'
section = 'reeem'


def log():
    """configure logging"""
    logger = logging.getLogger('EEEE')
    logger.setLevel(logging.INFO)
    ch = logging.StreamHandler()
    ch.setLevel(logging.INFO)
    formatter = logging.Formatter('%(asctime)s %(message)s',
                                    datefmt='%Y-%m-%d %I:%M:%S')
    return logger

## config file
def config_set(section, key, value):
    """
    create config file.
    sets a value to a [section] key - pair.

    :param section: the section.
    :type section: str.
    :param key: the key.
    :type key: str.
    :param value: the value.
    :type value: float, int, str.
    """

    with open(configfile, 'w') as config:    # save
        if not cfg.has_section(section):
            cfg.add_section(section)
        cfg.set(section, 'username', key)
        cfg.set(section, 'database', database)
        cfg.set(section, 'host', '130.XXX.XX.XX')
        cfg.set(section, 'port', port)
        cfg.set(section, 'password', value)
        cfg.write(config)


def config_file():
    """ Load user and pw from config file """
    
    if os.path.isfile(configfile):
        file = configfile
    else:
        file_not_found = configfile
        config_file_not_found_message(file_not_found)
    
    config_init(file)


def config_init(FILE):
    """
    Read config file

    :param FILE: config file
    :type FILE: str
    """
    
    try:
        cfg.read(FILE)
        global _loaded
        _loaded = True
        print('Load ' + FILE)
    except:
        config_file_not_found_message(FILE)


def config_get(key):
    """
    Read data from reeem_io_config.ini file

    :param key: config entries
    :type key: str
    """
    
    if not _loaded:
        config_init(FILE)
    try:
        return cfg.getfloat(section, key)
    except Exception:
        try:
            return cfg.getint(section, key)
        except:
            try:
                return cfg.getboolean(section, key)
            except:
                return cfg.get(section, key)
    
    return cfg.getfloat(key)


def config_file_not_found_message(FILE):
    """
    Show error message incl. help if file not found

    :param filename: config file
    :type filename: str
    """

    print('No config file found!')


## database connection
def reeem_session():
    """SQLAlchemy session object with valid connection to reeem database"""

    #host = input('host (default 130.226.55.43): ')
    host = '130.226.55.43'
    # print('host: ' + host)
    
    #port = input('port (default 5432): ')
    global port
    port = '5432'
    # print('port: ' + port)
    
    #database = input("database name (default 'reeem'): ")
    global database
    database = 'reeem'
    # print('database: ' + database)
    
    #user = ''
    try:
        config_file()
        user = config_get("username")
        print('Hello ' + user + '!')
    except:
        print('Please provide connection parameters.')
        user = input('User name (default surname_name): ')
    
    # password = ''
    try:
        password = config_get("password")
    except: 
        password = getpass.getpass(prompt='Password: ',
            stream=sys.stderr)
        config_set(section, key=user, value=password)
        print('Config file created!')
    
    # engine
    try:
        con = create_engine(
            'postgresql://' + '%s:%s@%s:%s/%s' % (user,
                                                    password,
                                                    host,
                                                    port,
                                                    database)).connect()
    except:
        print('Password authentication failed for user "{}"'.format(user))
        os.remove(configfile)
        print('Existing config file deleted! Restart stript and try again!')

    return con
    print('Database connection established!')


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
        SELECT  '{0}' AS version,
                '{1}' AS io,
                '{2}' AS schema_name,
                '{3}' AS table_name,
                '{4}' AS script_name,
                COUNT(*)AS entries,
                '{5}' AS comment,
                session_user AS user_name,
                NOW() AT TIME ZONE 'Europe/Berlin' AS timestamp,
                obj_description('{2}.{3}' ::regclass) ::json AS metadata
        FROM    {2}.{3};""".format(version,io,schema,table,script,comment))
    con.execute(sql)


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
