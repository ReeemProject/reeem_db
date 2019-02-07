/*
UCL behaviour Table Setup

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Alexis Michaltsis"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/23"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/blob/master/database_setup/reeem_db_setup_ucl_behaviour.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- UCL behaviour input
DROP TABLE IF EXISTS    model_draft.reeem_ucl_behaviour_input CASCADE;
CREATE TABLE            model_draft.reeem_ucl_behaviour_input (
    "id"            serial NOT NULL,
    "nid"           integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "schema"        text,
    "field"         text,
    "category"      text,
    "region"        text,
    "year"          smallint,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "tags"          hstore,
    "updated"       timestamp with time zone,
    "source"        text,
    CONSTRAINT reeem_ucl_behaviour_input_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_ucl_behaviour_input OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_ucl_behaviour_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_ucl_behaviour_input IS
    '{"title": "",
    "description": "",
    "language": [ "eng", "ger" ],
    "spatial":
        {"location": "",
        "extent": "",
        "resolution": ""},
    "temporal":
        {"reference_date": "",
        "start": "",
        "end": "",
        "resolution": ""},
    "sources": [
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""},
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""} ],
    "license":
        {"id": "",
        "name": "",
        "version": "",
        "url": "",
        "instruction": "",
        "copyright": ""},
    "contributors": [
        {"name": "4lm", "email": "none", "date": "2019-02-07", "comment": "Create table"},
        {"name": "", "email": "", "date": "", "comment": ""} ],
    "resources": [
        {"name": "model_draft.reeem_model_data_template",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Parameter ID", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "schema", "description": "1. classification", "unit": "none"},
            {"name": "category", "description": "2. classification", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "source", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.1.0','setup','model_draft','reeem_ucl_behaviour_input','reeem_db_setup_ucl_behaviour.sql',' ');


-- UCL behaviour output
DROP TABLE IF EXISTS    model_draft.reeem_ucl_behaviour_output CASCADE;
CREATE TABLE            model_draft.reeem_ucl_behaviour_output (
    "id"            serial NOT NULL,
    "nid"           integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "schema"        text,
    "field"         text,
    "category"      text,
    "region"        text,
    "year"          smallint,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "tags"          hstore,
    "updated"       timestamp with time zone,
    "source"        text,
    CONSTRAINT reeem_ucl_behaviour_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_ucl_behaviour_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_ucl_behaviour_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_ucl_behaviour_output IS
    '{"title": "",
    "description": "",
    "language": [ "eng", "ger" ],
    "spatial":
        {"location": "",
        "extent": "",
        "resolution": ""},
    "temporal":
        {"reference_date": "",
        "start": "",
        "end": "",
        "resolution": ""},
    "sources": [
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""},
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""} ],
    "license":
        {"id": "",
        "name": "",
        "version": "",
        "url": "",
        "instruction": "",
        "copyright": ""},
    "contributors": [
        {"name": "4lm", "email": "none", "date": "2019-02-07", "comment": "Create table"} ],
    "resources": [
        {"name": "model_draft.reeem_model_data_template",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Parameter ID", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "schema", "description": "1. classification", "unit": "none"},
            {"name": "category", "description": "2. classification", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "source", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.1.0','setup','model_draft','reeem_ucl_behaviour_output','reeem_db_setup_ucl_behaviour.sql',' ');
