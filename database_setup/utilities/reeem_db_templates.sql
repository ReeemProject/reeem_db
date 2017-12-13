/*
REEEM database templates (SQL)

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
*/


-- table description
DROP TABLE IF EXISTS    model_draft.template_table CASCADE;
CREATE TABLE            model_draft.template_table (
    "id"            serial NOT NULL,
    "pathway"       text,
    "version"       text,
    "schema"        text,
    "category"      text,
    "tags"          hstore,
    "region"        text,
    "year"          smallint,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "updated"       timestamp with time zone,
    "source"        text,
    CONSTRAINT template_table_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.template_table OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.template_table TO reeem_read WITH GRANT OPTION;

-- metadata template
COMMENT ON TABLE model_draft.template_table IS 
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
        {"name": "Ludee", "email": "none", "date": "2017--", "comment": "Create table"},
        {"name": "", "email": "", "date": "", "comment": ""} ],
    "resources": [
        {"name": "model_draft.template_table",        
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
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
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "source", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1.0','setup','model_draft','template_table','reeem_db_templates.sql',' ');


-- insert data
INSERT INTO model_draft.template_table (pathway, version, schema, category, tags, region, year, indicator, value, unit, aggregation, updated, source) VALUES
    ('Test_data', 'v1', 'schema', 'category', '"energy_type" => "Electric"'::hstore, 'EU28', '2015', 'RE share', 2, '%', TRUE, now(), 'book' ),
    ('Test_data', 'v1', 'schema', 'category', '"energy_type" => "Electric"'::hstore, 'EU28', '2050', 'RE share', 100, '%', TRUE, now(), 'book' );
