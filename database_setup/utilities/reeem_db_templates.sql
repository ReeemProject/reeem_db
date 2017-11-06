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
    id          serial NOT NULL,
    version     text,
    region      text,
    field       text,
    category    text,
    "indicator" text,
    "year"      integer,
    "value"     double precision,
    unit        text,
    aggregation boolean,
    updated     timestamp with time zone,
    source      text,
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
            {"name": "version", "description": "REEEM version number", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "field", "description": "Area or sector (1. level)", "unit": "none"},
            {"name": "category", "description": "Group (2. level)", "unit": "none"},
            {"name": "indicator", "description": "Parameter (3. level)", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "value", "description": "Specific value", "unit": "unit"},
            {"name": "unit", "description": "Unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "sources", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1.0','setup','model_draft','template_table','reeem_db_templates.sql',' ');


-- insert data
INSERT INTO model_draft.template_table (version,region,field,category,"indicator","year","value",unit,aggregation,updated,source) VALUES
    ('v0.1.0', 'EU28', 'test', 'test', 'test', 2050, 100, '%', TRUE, now(), 'test' ),
    ('v0.1.0', 'USD', 'test', 'test', 'test', 2050, 100, '%', TRUE, now(), 'test' );
