/*
Scenario Log function
Function to add an entry to the scenario log table

- Scenario Log function
- REEEM scenario log function (old)

Inputs:
    project,version,io,schema_name,table_name,script_name,comment

Outputs:
    id          SERIAL,
    project     text,
    version     text,
    io          text,
    schema_name text,
    table_name  text,
    script_name text,
    entries     integer,
    "comment"   text,
    user_name   text,
    "timestamp" timestamp,
    metadata    text

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"

 * This file is part of project REEEM. It's copyrighted by the contributors
 * recorded in the version control history of the file, available from
 * its original location https://github.com/ReeemProject/reeem_db/blob/master/database_setup/utilities/functions/reeem_scenario_log.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- Scenario Log function
DROP FUNCTION IF EXISTS     scenario_log(text,text,text,text,text,text,text);
CREATE OR REPLACE FUNCTION  scenario_log(text,text,text,text,text,text,text)
    RETURNS text AS 
    $$
    DECLARE
        _project        ALIAS FOR $1;
        _version        ALIAS FOR $2;
        _io             ALIAS FOR $3;
        _schema_name    ALIAS FOR $4;
        _table_name     ALIAS FOR $5;
        _script_name    ALIAS FOR $6;
        _comment        ALIAS FOR $7;
    BEGIN
        EXECUTE 'INSERT INTO model_draft.scenario_log ' ||
            '(project,version,io,schema_name,table_name,script_name,entries,comment,user_name,timestamp,metadata)
            SELECT ' || quote_literal(_project) || ',' || 
                quote_literal(_version) || ',' || 
                quote_literal(_io) || ',' ||
                quote_literal(_schema_name) || ',' ||
                quote_literal(_table_name) || ',' ||
                quote_literal(_script_name) || ',' ||
                'COUNT(*),' ||
                quote_literal(_comment) || ',' || 
                'session_user,' ||
                E'NOW() AT TIME ZONE \'Europe/Berlin\' ,' ||
                E'obj_description(\'' || _schema_name || '.' || _table_name  || E'\' ::regclass) ::json ' || 
            'FROM ' || _schema_name || '.' || _table_name || ';' ;
        RETURN 'inserted';
    END;
    $$ LANGUAGE plpgsql;

ALTER FUNCTION              scenario_log(text,text,text,text,text,text,text) OWNER TO reeem_admin;
GRANT EXECUTE ON FUNCTION   scenario_log(text,text,text,text,text,text,text) TO reeem_user;

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.1.0','setup','model_draft','scenario_log','reeem_scenario_log.sql','Function test');

-- select latest entry
SELECT * FROM model_draft.scenario_log ORDER BY timestamp DESC LIMIT 1;


-- REEEM scenario log function (old)
DROP FUNCTION IF EXISTS     reeem_scenario_log(text,text,text,text,text,text);
CREATE OR REPLACE FUNCTION  reeem_scenario_log(text,text,text,text,text,text)
    RETURNS int AS $PROC$
DECLARE
    _version        ALIAS FOR $1;
    _io             ALIAS FOR $2;
    _schema_name    ALIAS FOR $3;
    _table_name     ALIAS FOR $4;
    _script_name    ALIAS FOR $5;
    _comment        ALIAS FOR $6;

    BEGIN
        EXECUTE 'INSERT INTO model_draft.reeem_scenario_log ' ||
            '(version,io,schema_name,table_name,script_name,entries,comment,user_name,timestamp,metadata)
            SELECT ' || quote_literal(_version) || ',' || 
                quote_literal(_io) || ',' ||
                quote_literal(_schema_name) || ',' ||
                quote_literal(_table_name) || ',' ||
                quote_literal(_script_name) || ',' ||
                'COUNT(*),' ||
                quote_literal(_comment) || ',' || 
                'session_user,' ||
                E'NOW() AT TIME ZONE \'Europe/Berlin\' ,' ||
                E'obj_description(\'' || _schema_name || '.' || _table_name  || E'\' ::regclass) ::json ' || 
            'FROM ' || _schema_name || '.' || _table_name || ';' ;
        RETURN 1;
    END;
    $PROC$ LANGUAGE plpgsql;

ALTER FUNCTION              reeem_scenario_log(text,text,text,text,text,text) OWNER TO reeem_admin;
GRANT EXECUTE ON FUNCTION   reeem_scenario_log(text,text,text,text,text,text) TO reeem_user;

-- reeem scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0','setup','model_draft','reeem_scenario_log','reeem_scenario_log.sql','Function test');
