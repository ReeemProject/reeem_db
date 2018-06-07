/*
EcoSense Table Setup

EcoSense Input
EcoSense Output

https://github.com/ReeemProject/reeem_db/issues/7

__copyright__   = "� Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig H�lk"
*/

/*
-- EcoSense Input
DROP TABLE IF EXISTS    model_draft.reeem_ecosense_input CASCADE;
CREATE TABLE            model_draft.reeem_ecosense_input (
    id              serial NOT NULL,
    pathway         text,
    version         text,
    nid             integer,
    region          text,
    sector_id       text,
    sector_name     text,
    scenario_name   text,
    "year"          smallint,
    "indicator"     text,
    "value"         double precision,
    unit            text,
    updated         timestamp with time zone,
    source          text,
    CONSTRAINT reeem_ecosense_input_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_ecosense_input OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_ecosense_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_ecosense_input IS 
    '{"title": "REEEM EcoSense Input - Emissions",
    "description": "none",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Europe",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2010",
        "start": "2015",
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
        {"name": "Ludee", "email": "none", "date": "2017-05-09", "comment": "Create table"},
        {"name": "Ludee", "email": "none", "date": "2017-11-08", "comment": "Update structure and metadata"},
        {"name": "", "email": "", "date": "", "comment": ""} ],
    "resources": [
        {"name": "model_draft.reeem_emc2_input",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "sector_id ", "description": "Sector identifier", "unit": "none" },
            {"name": "sector_name ", "description": "Sector name", "unit": "none" },
            {"name": "sector_id ", "description": "Sector identifier", "unit": "none" },
            {"name": "scenario_name", "description": "Scenario name", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "indicator", "description": "Parameter (3. level)", "unit": "none"},
            {"name": "value", "description": "Specific value", "unit": "unit"},
            {"name": "unit", "description": "Unit", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "sources", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1.0','setup','model_draft','reeem_emc2_input','reeem_db_setup_ecosense.sql',' ');
*/


-- EcoSense Output
DROP TABLE IF EXISTS    model_draft.reeem_ecosense_output CASCADE;
CREATE TABLE            model_draft.reeem_ecosense_output (
    "id"            serial NOT NULL,
    "nid"           integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "region"        text,
    "region_2"      text,
    "year"          smallint,
    "category"      text,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "tags"          hstore,
    "updated"       timestamp with time zone,
    CONSTRAINT reeem_ecosense_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_ecosenseeva_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_ecosenseeva_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_ecosenseeva_output IS 
    '{"title": "REEEM EcoSense Output",
    "description": "Health externalities",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Europe",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2010",
        "start": "2015",
        "end": "2050",
        "resolution": "5 years"},
    "sources": [
        {"name": "TIMES PanEU emisison data", "description": "uses emission data from TIMES PanEU results for respective pahtways, framework and data version", "url": "none", "license": "none", "copyright": "none"},
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""} ],
    "license":
        {"id": "ODC-BY-1.0",
        "name": "Open Data Commons Attribution License 1.0",
        "version": "1.0",
        "url": "http://opendatacommons.org/licenses/by",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!",
        "copyright": ""© Institut für Energiewirtschaft und Rationelle Energieanwendung (IER) der Universität Stuttgart"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2017-05-09", "comment": "Create table"},
        {"name": "Ludee", "email": "none", "date": "2017-11-08", "comment": "Update structure and metadata"},
        {"name": "Ludee", "email": "none", "date": "2018-04-12", "comment": "Finalize structure and update metadata"} 
        {"name": "doroschmid", "email": "none", "date": 2018-06-07". "comment": "Update structure and metada"}],
    "resources": [
        {"name": "model_draft.reeem_ecosense_output",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "region", "description": "Country (responsible for impacts)", "unit": "none"},
            {"name": "region_2", "description": "Country (where impacts occur)", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "category", "description": "2. classification", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.1.0','setup','model_draft','reeem_ecosense_output','reeem_db_setup_ecosense.sql',' ');
