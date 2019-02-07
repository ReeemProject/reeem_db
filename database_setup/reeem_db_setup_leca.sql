/*
LEcA Table Setup

LEcA Input
LEcA Output

https://github.com/ReeemProject/reeem_db/issues/9

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
*/


-- LeCA Input
DROP TABLE IF EXISTS    model_draft.reeem_leca_input CASCADE;
CREATE TABLE            model_draft.reeem_leca_input (
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
    CONSTRAINT reeem_leca_input_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_leca_input OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_leca_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_leca_input IS 
    '{"title": "REEEM LeCA Input",
    "description": "",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Lithuania",
        "resolution": "none"},
    "temporal": 
        {"reference_date": "2016",
        "start": "2016",
        "end": "2110",
        "resolution": "5 years"},
    "sources": [
        {"name": "MESSAGE",
        "description": "Biomass demands ",
        "url": "none",
        "license": "none",
        "copyright": "none"} ],
    "license":
        {"id": "tba",
        "name": "tba",
        "version": "tba",
        "url": "tba",
        "instruction": "tba",
        "copyright": "tba"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2018-11-12", "comment": "Create table and metadata"},
        {"name": "4lm", "email": "none", "date": "2019-01-31", "comment": "Update structure and metadata"} ],
    "resources": [
        {"name": "model_draft.reeem_leca_input",
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
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_leca_input','reeem_db_setup_leca.sql',' ');


-- LeCA Output
DROP TABLE IF EXISTS    model_draft.reeem_leca_output CASCADE;
CREATE TABLE            model_draft.reeem_leca_output (
    "id"            serial NOT NULL,
    "rid"           integer,
    "nid"           integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "scenario"      text,
    "region"        text,
    "schema"        text,
    "field"         text,
    "category"      text,
    "set"           text,
    "year"          smallint,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "tags"          hstore,
    "updated"       timestamp with time zone,
    "source"        text,
    CONSTRAINT reeem_leca_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_leca_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_leca_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_leca_output IS 
    '{"title": "REEEM LeCA Output",
    "description": "Bioenergy supply and impacts on other ecosystem services",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Lithuania",
        "resolution": "25 m x 25 m"},
    "temporal": 
        {"reference_date": "2016",
        "start": "2016",
        "end": "2110",
        "resolution": "5 years"},
    "sources": [
        {"name": "MESSAGE",
        "description": "Biomass demands ",
        "url": "none",
        "license": "none",
        "copyright": "none"} ],
    "license":
        {"id": "tba",
        "name": "tba",
        "version": "tba",
        "url": "tba",
        "instruction": "tba",
        "copyright": "tba"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2018-11-12", "comment": "Create table and metadata"}],
    "resources": [
        {"name": "model_draft.reeem_leca_output",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
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
            {"name": "updated", "description": "Timestamp", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_leca_output','reeem_db_setup_leca.sql',' ');
