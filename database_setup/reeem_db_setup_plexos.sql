/*
PLEXOS Table Setup

PLEXOS Input
PLEXOS Output

https://github.com/ReeemProject/reeem_db/issues/14

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/14"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/reeem_db_setup_times_paneu.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- PLEXOS Input
DROP TABLE IF EXISTS    model_draft.reeem_plexos_input CASCADE;
CREATE TABLE            model_draft.reeem_plexos_input (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "region"        text,
    "year"          smallint,
    "schema"        text,
    "field"         text,
    "category"      text,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "tags"          hstore,
    "updated"       timestamp with time zone,
    "source"        text,
    CONSTRAINT reeem_plexos_input_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_plexos_input OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_plexos_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_plexos_input IS 
    '{"title": "REEEM Plexos Input",
    "description": "none",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "BG, HR, HU, RO, SI",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2030",
        "start": "none",
        "end": "none",
        "resolution": "none"},
    "sources": [
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""},
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""} ],
    "license":
        {"id": "tba",
        "name": "tba",
        "version": "tba",
        "url": "tba",
        "instruction": "tba",
        "copyright": "tba"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2017-11-20", "comment": "Create table"},
        {"name": "", "email": "", "date": "", "comment": ""} ],
    "resources": [
        {"name": "model_draft.reeem_plexos_input",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "category", "description": "2. classification", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "sources", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1.0','setup','model_draft','reeem_plexos_input','reeem_db_setup_plexos.sql',' ');


-- PLEXOS Output
DROP TABLE IF EXISTS    model_draft.reeem_plexos_output CASCADE;
CREATE TABLE            model_draft.reeem_plexos_output (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "region"        text,
    "year"          smallint,
    "schema"        text,
    "field"         text,
    "category"      text,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "tags"          hstore,
    "updated"       timestamp with time zone,
    CONSTRAINT reeem_plexos_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_plexos_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_plexos_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_plexos_output IS 
    '{"title": "REEEM Plexos Input",
    "description": "none",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "BG, HR, HU, RO, SI",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2030",
        "start": "none",
        "end": "none",
        "resolution": "none"},
    "sources": [
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""},
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""} ],
    "license":
        {"id": "tba",
        "name": "tba",
        "version": "tba",
        "url": "tba",
        "instruction": "tba",
        "copyright": "tba"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2017-11-20", "comment": "Create table"},
        {"name": "", "email": "", "date": "", "comment": ""} ],
    "resources": [
        {"name": "model_draft.reeem_plexos_output",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "schema", "description": "Database schema", "unit": "none"},
            {"name": "field", "description": "Area or sector (1. level)", "unit": "none"},
            {"name": "category", "description": "Group (2. level)", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "indicator", "description": "Parameter (3. level)", "unit": "none"},
            {"name": "value", "description": "Specific value", "unit": "unit"},
            {"name": "unit", "description": "Unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "sources", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1.0','setup','model_draft','reeem_plexos_output','reeem_db_setup_plexos.sql',' ');