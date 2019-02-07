/*
EMC2 Table Setup

EMC2 Input
EMC2 Output

https://github.com/ReeemProject/reeem_db/issues/48

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
*/


-- EMC2 Input
DROP TABLE IF EXISTS    model_draft.reeem_emc2_input CASCADE;
CREATE TABLE            model_draft.reeem_emc2_input (
    id              serial NOT NULL,
    pathway         text,
    version         text,
    nid             integer,
    region          text,
    sector_id       text,
    "year"          smallint,
    "indicator"     text,
    "value"         double precision,
    unit            text,
    notation        text,
    updated         timestamp with time zone,
    source          text,
    "framework"     text,
    "schema"        text,
    "field"         text,
    "category"      text,
    "aggregation"   boolean,
    "tags"          hstore,
    CONSTRAINT reeem_emc2_input_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_emc2_input OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_emc2_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_emc2_input IS 
    '{"title": "REEEM EMC2 Input - Emissions",
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
        {"name": "4lm", "email": "none", "date": "2019-02-07", "comment": "Update structure"} ],
    "resources": [
        {"name": "model_draft.reeem_emc2_input",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "sector_id ", "description": "Sector", "unit": "none" },
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "indicator", "description": "Parameter (3. level)", "unit": "none"},
            {"name": "value", "description": "Specific value", "unit": "unit"},
            {"name": "unit", "description": "Unit", "unit": "none"},
            {"name": "notation", "description": "Notation", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "sources", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1.0','setup','model_draft','reeem_emc2_input','reeem_db_setup_emc2.sql',' ');


-- EMC2 Output
DROP TABLE IF EXISTS    model_draft.reeem_emc2_output CASCADE;
CREATE TABLE            model_draft.reeem_emc2_output (
    id              serial NOT NULL,
    pathway         text,
    version         text,
    nid             integer,
    grid_id         integer,
    region          text,
    snap1           text,
    "year"          smallint,
    "indicator"     text,
    "value"         double precision,
    unit            text,
    updated         timestamp with time zone,
    source          text,
    "framework"     text,
    "schema"        text,
    "field"         text,
    "category"      text,
    "aggregation"   boolean,
    "tags"          hstore,
    CONSTRAINT reeem_emc2_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_emc2_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_emc2_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_emc2_output IS 
    '{"title": "REEEM EMC2 Output - Emissions",
    "description": "none",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Europe",
        "resolution": "5 km"},
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
        {"name": "4lm", "email": "none", "date": "2019-02-07", "comment": "Update structure"} ],
    "resources": [
        {"name": "model_draft.reeem_emc2_output",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "grid_id", "description": "Grid 5km", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "snap1", "description": "SNAP1", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "indicator", "description": "Parameter (3. level)", "unit": "none"},
            {"name": "value", "description": "Specific value", "unit": "unit"},
            {"name": "unit", "description": "Unit", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "sources", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1','setup','model_draft','reeem_emc2_output','reeem_db_setup_emc2.sql',' ');
