/*
Model Data template (SQL)

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/blob/master/database_setup/utilities/reeem_example_table.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- table description
DROP TABLE IF EXISTS    model_draft.model_data_template CASCADE;
CREATE TABLE            model_draft.model_data_template (
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
    CONSTRAINT model_data_template_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.model_data_template OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.model_data_template TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.model_data_template IS 
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
        {"name": "model_draft.model_data_template",        
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
SELECT scenario_log('REEEM','v0.1.0','setup','model_draft','model_data_template','reeem_db_templates.sql',' ');


-- insert test data
INSERT INTO model_draft.model_data_template (pathway, version, schema, category, tags, region, year, indicator, value, unit, aggregation, updated, source) VALUES
    ('Test_data', 'v1', 'schema', 'category', '"energy_type" => "Electric"'::hstore, 'EU28', '2015', 'RE share', 2, '%', TRUE, now(), 'book' ),
    ('Test_data', 'v1', 'schema', 'category', '"energy_type" => "Electric"'::hstore, 'EU28', '2050', 'RE share', 100, '%', TRUE, now(), 'book' );
