/*
OSeMOSYS MESCA Table Setup

OSeMOSYS MESCA Input
OSeMOSYS MESCA Output

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/45"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/reeem_db_setup_osemosys_mesca.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- OSeMOSYS MESCA input
DROP TABLE IF EXISTS    model_draft.reeem_osemosys_mesca_input CASCADE;
CREATE TABLE            model_draft.reeem_osemosys_mesca_input (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
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
    CONSTRAINT reeem_osemosys_mesca_input_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_osemosys_mesca_input OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_osemosys_mesca_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_osemosys_mesca_input IS 
    '{"title": "REEEM OSeMOSYS MESCA Input",
    "description": "Input parameters: Costs, Lifetime, Efficiency, Final demand",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "EE, FI, LT, LV",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2015",
        "start": "2015",
        "end": "2050",
        "resolution": "1 years"},
    "sources": [
        {"name": "TIMES PanEU", "description": "", "url": "", "license": "", "copyright": ""},
	{"name": "MESSAGE", "description": "", "url": "", "license": "", "copyright": ""},
        {"name": "Technology data catalogue, 2018", "description": "", "url": "", "license": "", "copyright": ""} ],
    "license":
        {"id": "tba",
        "name": "tba",
        "version": "tba",
        "url": "tba",
        "instruction": "tba",
        "copyright": "tba"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2019-01-28", "comment": "Create table and metadata"},
        {"name": "Linas", "email": "none", "date": "2019-01-29", "comment": "Update metadata"} ],
    "resources": [
        {"name": "model_draft.reeem_osemosys_mesca_input",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "schema", "description": "1. classification", "unit": "none"},
            {"name": "field", "description": "2. classification", "unit": "none"},
            {"name": "category", "description": "3. classification", "unit": "none"},
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
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_osemosys_mesca_input','reeem_db_setup_osemosys_mesca.sql',' ');


-- OSeMOSYS MESCA Output
DROP TABLE IF EXISTS    model_draft.reeem_osemosys_mesca_output CASCADE;
CREATE TABLE            model_draft.reeem_osemosys_mesca_output (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
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
    CONSTRAINT reeem_osemosys_mesca_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_osemosys_mesca_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_osemosys_mesca_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_osemosys_mesca_output IS 
    '{"title": "REEEM OSeMOSYS MESCA Output",
    "description": "Model provides Energy Security Coefficient (ESC)",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "EE, FI, LT, LV",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2015",
        "start": "2015",
        "end": "2050",
        "resolution": "1 years"},
    "sources": [
        {"name": "OSeMOSYS MESCA", "description": "Model provides Energy Security Coefficient (ESC)", "url": "tba", "license": "none", "copyright": "none"} ],
    "license":
        {"id": "tba",
        "name": "tba",
        "version": "tba",
        "url": "tba",
        "instruction": "tba",
        "copyright": "tba"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2019-01-28", "comment": "Create table and metadata"},
        {"name": "Linas", "email": "none", "date": "2019-01-29", "comment": "Update metadata"} ],
    "resources": [
        {"name": "model_draft.reeem_osemosys_mesca_output",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "schema", "description": "1. classification", "unit": "none"},
            {"name": "field", "description": "2. classification", "unit": "none"},
            {"name": "category", "description": "3. classification", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_osemosys_mesca_output','reeem_db_setup_osemosys_mesca.sql',' ');
