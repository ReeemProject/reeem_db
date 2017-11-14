/*
OSeMOSYS Table Setup

OSeMOSYS PanEU Input
OSeMOSYS PanEU Output

https://github.com/ReeemProject/reeem_db/issues/13

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
*/


-- OSeMOSYS PanEU Input
DROP TABLE IF EXISTS    model_draft.reeem_osemosys_paneu_input CASCADE;
CREATE TABLE            model_draft.reeem_osemosys_paneu_input (
    id              serial NOT NULL,
    pathway         text,
    version         text,
    nid             integer,
    dfid            integer,
    region          text,
    field           text,
    category        text,   -- "table"
    "year"          smallint,
    "indicator"     text,   -- "name"
    "value"         double precision,
    aggregation     boolean,
    updated         timestamp with time zone,
    source          text,
    CONSTRAINT reeem_osemosys_paneu_input_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_osemosys_paneu_input OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_osemosys_paneu_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_osemosys_paneu_input IS '{
    "title": "REEEM OSeMOSYS PanEU Input",
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
        {"name": "", "email": "", "date": "", "comment": ""} ],
    "resources": [
        {"name": "model_draft.reeem_osemosys_paneu_input",        
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
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
SELECT reeem_scenario_log('v0.1','setup','model_draft','reeem_osemosys_paneu_input','reeem_db_setup_osemosys_paneu.sql',' ');


-- OSeMOSYS PanEU Output
DROP TABLE IF EXISTS     model_draft.reeem_osemosys_paneu_output CASCADE;
CREATE TABLE         model_draft.reeem_osemosys_paneu_output (
    id              serial NOT NULL,
    pathway         text,
    version         text,
    nid             integer,
    dfid            integer,
    region          text,
    field           text,
    category        text,   -- "table"
    "year"          smallint,
    "indicator"     text,   -- "name"
    "value"         double precision,
    unit            text,
    aggregation     boolean,
    updated         timestamp with time zone,
    source          text,
    CONSTRAINT reeem_osemosys_paneu_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_osemosys_paneu_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_osemosys_paneu_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_osemosys_paneu_output IS '{
    "title": "REEEM OSeMOSYS PanEU Output",
    "description": "Output parameters: ",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Europe",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2015",
        "start": "2015",
        "end": "2055",
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
        {"name": "", "email": "", "date": "", "comment": ""} ],
    "resources": [
        {"name": "model_draft.reeem_osemosys_paneu_output",        
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
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
SELECT reeem_scenario_log('v0.1','setup','model_draft','reeem_osemosys_paneu_output','reeem_db_setup_osemosys_paneu.sql',' ');
