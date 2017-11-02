/*
Times PanEU table setup
Times PanEU Input
Times PanEU Output

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
*/


-- times paneu input
DROP TABLE IF EXISTS    model_draft.reeem_times_paneu_input CASCADE;
CREATE TABLE            model_draft.reeem_times_paneu_input (
    id          serial NOT NULL,
    dfid        integer,
    version     varchar(10),
    region      varchar(4),
    "table"     text,
    name        text,
    nid         integer,
    "year"      integer,
    "value"     double precision,
    unit        varchar(15),
    aggregation boolean,
    updated     timestamp with time zone,
    sources     text,
    CONSTRAINT reeem_times_paneu_input_pkey PRIMARY KEY (id) );

ALTER TABLE             model_draft.reeem_times_paneu_input OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_times_paneu_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_times_paneu_input IS 
    '{"title": "REEEM Times PanEU Input",
    "description": "Service Demands, Fuel Prices, Potentials",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Europe",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2010",
        "start": "2010",
        "end": "2050",
        "resolution": "5 years"},
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
        {"name": "Ludee", "email": "none", "date": "2016-12-01", "comment": "Create table"},
        {"name": "Ludee", "email": "none", "date": "2017-01-18", "comment": "Update metadata"},
        {"name": "Ludee", "email": "none", "date": "2017-07-24", "comment": "Update metadata"},
        {"name": "Ludee", "email": "none", "date": "2017-11-02", "comment": "Update structure"},
        {"name": "", "email": "", "date": "", "comment": ""} ],
    "resources": [
        {"name": "model_draft.reeem_times_paneu_input",        
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
            {"name": "version", "description": "Internal version number", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "table", "description": "Times table name", "unit": "none"},
            {"name": "name", "description": "Times variable name", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "value", "description": "Value", "unit": "unit"},
            {"name": "unit", "description": "Unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "sources", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

SELECT obj_description('model_draft.reeem_times_paneu_input' ::regclass) ::json;

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1.0','setup','model_draft','reeem_times_paneu_input','reeem_db_setup_times_paneu.sql',' ');


-- times paneu output
DROP TABLE IF EXISTS    model_draft.reeem_times_paneu_output CASCADE;
CREATE TABLE            model_draft.reeem_times_paneu_output (
    id          serial NOT NULL,
    dfid        integer,
    version     varchar(5),
    region      varchar(4),
    "table"     text,
    name        text,
    nid         integer,
    "year"      integer,
    "value"     double precision,
    unit        varchar(15),
    aggregation boolean,
    updated     timestamp with time zone,
    sources     text,
    CONSTRAINT reeem_times_paneu_output_pkey PRIMARY KEY (id) );
    
ALTER TABLE        model_draft.reeem_times_paneu_output OWNER TO reeem_user;
GRANT SELECT ON TABLE    model_draft.reeem_times_paneu_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_times_paneu_output IS 
    '{"title": "REEEM Times PanEU Output",
    "description": "Energy Consumption, Installed Capacities, Electricity Production, Heat Production, Fuel Input, Emissions, Mobility, Electricity Exchange",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Europe",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2010",
        "start": "2010",
        "end": "2050",
        "resolution": "5 years"},
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
        {"name": "Ludee", "email": "none", "date": "2016-12-01", "comment": "Create table"},
        {"name": "Ludee", "email": "none", "date": "2017-01-18", "comment": "Update metadata"},
        {"name": "Ludee", "email": "none", "date": "2017-07-24", "comment": "Update metadata"},
        {"name": "Ludee", "email": "none", "date": "2017-11-02", "comment": "Update structure"},
        {"name": "", "email": "", "date": "", "comment": ""} ],
    "resources": [
        {"name": "model_draft.reeem_times_paneu_output",        
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
            {"name": "version", "description": "Internal version number", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "table", "description": "Times table name", "unit": "none"},
            {"name": "name", "description": "Times variable name", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "value", "description": "Value", "unit": "unit"},
            {"name": "unit", "description": "Unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "sources", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

SELECT obj_description('model_draft.reeem_times_paneu_output' ::regclass) ::json;

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1.0','setup','model_draft','reeem_times_paneu_output','reeem_db_setup_times_paneu.sql',' ');
