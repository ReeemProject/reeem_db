﻿/*
Scenario Log table setup

- Scenario Log table
- REEEM Scenario Log table (old)

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/utilities/reeem_setup_scenario_log.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- Scenario Log table
DROP TABLE IF EXISTS    model_draft.scenario_log CASCADE;
CREATE TABLE            model_draft.scenario_log (
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
    metadata    text,
    CONSTRAINT scenario_log_pkey PRIMARY KEY (id));

ALTER TABLE             model_draft.scenario_log OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.scenario_log TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.scenario_log IS '{
    "title": "Scenario Log",
    "description": "Logging of inputs and outputs of the database",
    "language": [ "eng" ],
    "spatial":
        {"location": "none",
        "extent": "none",
        "resolution": "none"},
    "temporal":
        {"reference_date": "none",
        "start": "none",
        "end": "none",
        "resolution": "none"},
    "sources": [
        {"name": "REEEM Project","description": "REEEM Database","url": "http://www.reeem.org/"},
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""} ],
    "license": 
        {"id": "ODbL-1.0",
        "name": "Open Data Commons Open Database License 1.0",
        "version": "1.0",
        "url": "https://opendatacommons.org/licenses/odbl/1.0/",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute, Share-Alike, Keep open!",
        "copyright": "© Reiner Lemoine Institut"},
    "contributors": [
        {"name": "Ludwig Hülk", "email": "none", "date": "2018-01-24", "comment": "Create table"} ],
    "resources": [
        {"name": "model_draft.scenario_log",        
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "unique identifier", "unit": "none" },
            {"name": "project", "description": "project name", "unit": "none" },
            {"name": "version", "description": "internal version number", "unit": "none" },
            {"name": "io", "description": "setup, input, output, temp", "unit": "none" },
            {"name": "schema_name", "description": "schema", "unit": "none" },
            {"name": "table_name", "description": "table", "unit": "none" },
            {"name": "script_name", "description": "source", "unit": "none" },
            {"name": "entries", "description": "number of rows", "unit": "none" },
            {"name": "comment", "description": "additional info", "unit": "none" },
            {"name": "user_name", "description": "database user", "unit": "none" },
            {"name": "timestamp", "description": "current time", "unit": "none" },
            {"name": "metadata", "description": "copy of the metadata", "unit": "none" } ] } ],
    "metadata_version": "1.3"}';

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.1','setup','model_draft','scenario_log','reeem_setup_scenario_log.sql','Update metadata');


-- REEEM Scenario Log table (old)
DROP TABLE IF EXISTS    model_draft.reeem_scenario_log CASCADE;
CREATE TABLE            model_draft.reeem_scenario_log (
    id          SERIAL,
    version     text,
    io          text,
    schema_name text,
    table_name  text,
    script_name text,
    entries     integer,
    "comment"   text,
    user_name   text,
    "timestamp" timestamp,
    metadata    text,
    CONSTRAINT reeem_scenario_log_pkey PRIMARY KEY (id));

ALTER TABLE             model_draft.reeem_scenario_log OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_scenario_log TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_scenario_log IS '{
    "title": "REEEM Scenario Log",
    "description": "Logging of inputs and outputs of the reeem_db",
    "language": [ "eng" ],
    "spatial":
        {"location": "none",
        "extent": "none",
        "resolution": "none"},
    "temporal":
        {"reference_date": "none",
        "start": "none",
        "end": "none",
        "resolution": "none"},
    "sources": [
        {"name": "REEEM Project","description": "REEEM Database","url": "http://www.reeem.org/"},
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""} ],
    "license": 
        {"id": "ODbL-1.0",
        "name": "Open Data Commons Open Database License 1.0",
        "version": "1.0",
        "url": "https://opendatacommons.org/licenses/odbl/1.0/",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute, Share-Alike, Keep open!",
        "copyright": "© Reiner Lemoine Institut"},
    "contributors": [
        {"name": "Ludwig Hülk", "email": "none", "date": "2016-12-01", "comment": "Create table"},
        {"name": "Ludwig Hülk", "email": "none", "date": "2017-01-18", "comment": "Update metadata"},
        {"name": "Ludwig Hülk", "email": "none", "date": "2018-01-24", "comment": "Update metadata and license"} ],
    "resources": [
        {"name": "model_draft.reeem_scenario_log",        
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "unique identifier", "unit": "none" },
            {"name": "version", "description": "internal version number", "unit": "none" },
            {"name": "io", "description": "setup, input, output, temp", "unit": "none" },
            {"name": "schema_name", "description": "schema", "unit": "none" },
            {"name": "table_name", "description": "table", "unit": "none" },
            {"name": "script_name", "description": "source", "unit": "none" },
            {"name": "entries", "description": "number of rows", "unit": "none" },
            {"name": "comment", "description": "additional info", "unit": "none" },
            {"name": "user_name", "description": "database user", "unit": "none" },
            {"name": "timestamp", "description": "current time", "unit": "none" },
            {"name": "metadata", "description": "copy of the metadata", "unit": "none" } ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1','setup','model_draft','reeem_scenario_log','reeem_setup_scenario_log.sql','Update metadata');
