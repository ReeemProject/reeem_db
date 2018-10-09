/*
OSeMBE Table Setup

OSeMBE Input
OSeMBE Output

https://github.com/ReeemProject/reeem_db/issues/13

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/13"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/reeem_db_setup_osembe.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- OSeMBE Input
DROP TABLE IF EXISTS    model_draft.reeem_osembe_input CASCADE;
CREATE TABLE            model_draft.reeem_osembe_input (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "schema"        text,
    "category"      text,
    "tags"          hstore,
    "field"         text,
    "region"        text,
    "year"          smallint,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "updated"       timestamp with time zone,
    "source"        text,
    CONSTRAINT reeem_osembe_input_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_osembe_input OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_osembe_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_osembe_input IS '{
    "title": "REEEM OSeMBE Input",
    "description": "Input parameters: Service Demands, Fuel Prices, Potentials",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Europe",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2015",
        "start": "2015",
        "end": "2060",
        "resolution": "1 year"},
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
        {"name": "Ludee", "email": "none", "date": "2017-07-24", "comment": "Create table"},
        {"name": "Ludee", "email": "none", "date": "2017-11-14", "comment": "Update structure and metadata"},
        {"name": "Ludee", "email": "none", "date": "2018-01-30", "comment": "New naming structure"} ],
    "resources": [
        {"name": "model_draft.reeem_osembe_input",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "schema", "description": "1. classification", "unit": "none"},
            {"name": "category", "description": "2. classification", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "field", "description": "Old classification", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "source", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.1','setup','model_draft','reeem_osembe_input','reeem_db_setup_osembe.sql',' ');


-- OSeMBE Output
DROP TABLE IF EXISTS    model_draft.reeem_osembe_output CASCADE;
CREATE TABLE            model_draft.reeem_osembe_output (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "schema"        text,
    "category"      text,
    "tags"          hstore,
    "field"         text,
    "region"        text,
    "year"          smallint,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "updated"       timestamp with time zone,
    "source"        text,
    CONSTRAINT reeem_osembe_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_osembe_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_osembe_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_osembe_output IS '{
    "title": "REEEM OSeMBE Output",
    "description": "Output parameters: ",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Europe (EU28+NO+CH)",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2015",
        "start": "2015",
        "end": "2050",
        "resolution": "1 year"},
    "sources": [
        {"name": "OSeMOSYS OSEMBE", "description": "The Open-Source energy Model Base for the European Union", "url": "http://www.osemosys.org/osembe.html", "license": "Apache License 2.0 (Apache-2.0)", "copyright": "tba"},
        {"name": "OSeMBE – An open-source engagement model", "description": "Model documentation", "url": "http://www.osemosys.org/uploads/1/8/5/0/18504136/osembe_documentation.pdf", "license": "none", "copyright": "none"},
        {"name": "OSeMBE input data", "description": "Data", "url": "http://www.osemosys.org/uploads/1/8/5/0/18504136/osembe_v1_20180821.zip", "license": "Open Data Commons Attribution License 1.0 (ODC-BY-1.0)", "copyright": "© Hauke Henke"}],
    "license": 
        {"id": "tba",
        "name": "tba",
        "version": "tba",
        "url": "tba",
        "instruction": "tba",
        "copyright": "tba"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2017-07-24", "comment": "Create table"},
        {"name": "Ludee", "email": "none", "date": "2017-11-14", "comment": "Update structure and metadata"},
        {"name": "Ludee", "email": "none", "date": "2018-01-30", "comment": "New naming structure"},
        {"name": "Ludee", "email": "none", "date": "2018-10-09", "comment": "Update table name and metadata"} ],
    "resources": [
        {"name": "model_draft.reeem_osembe_output",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "schema", "description": "1. classification", "unit": "none"},
            {"name": "category", "description": "2. classification", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "field", "description": "Old classification", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "source", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.1','setup','model_draft','reeem_osembe_output','reeem_db_setup_osembe.sql',' ');
