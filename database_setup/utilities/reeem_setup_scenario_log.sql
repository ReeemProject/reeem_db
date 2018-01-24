/*
Scenario Log setup
REEEM Scenario Log setup (old)

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
*/

-- scenario log
DROP TABLE IF EXISTS    model_draft.reeem_scenario_log CASCADE;
CREATE TABLE            model_draft.reeem_scenario_log (
    id SERIAL,
    version text,
    io text,
    schema_name text,
    table_name text,
    script_name text,
    entries integer,
    "comment" text,
    user_name text,
    "timestamp" timestamp,
    metadata text,
    CONSTRAINT reeem_scenario_log_pkey PRIMARY KEY (id));

ALTER TABLE             model_draft.reeem_scenario_log OWNER TO reeem_user; 
GRANT SELECT ON TABLE   model_draft.reeem_scenario_log TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_scenario_log IS '{
    "title": "REEEM scenario log",
    "description": "Logging of inputs and outputs",
    "language": [ "eng" ],
    "reference_date": "none",
    "spatial":
        {"extent": "none",
        "resolution": "none"},
    "temporal":
        {"start": "none",
        "end": "none",
        "resolution": "none"},
    "sources": [
        {"name": "REEEM Project","description": "REEEM Database","url": "http://www.reeem.org/"} ],
    "license": [
        {"id": "tba",
        "name": "tba",
        "version": "tba",
        "url": "tba",
        "instruction": "tba",
        "copyright": "tba"} ],
    "contributors": [
        {"name": "Ludwig Hülk", "email": "ludwig.huelk@rl-institut.de", "date": "2016-12-01", "comment": "created table"},
        {"name": "Ludwig Hülk", "email": "ludwig.huelk@rl-institut.de", "date": "2017-01-18", "comment": "updated metadata"} ],
    "resources": [
        {"name": "model_draft.reeem_scenario_log",        
        "format": "sql",
        "fields": [
            {"name": "id", "description": "unique identifier", "unit": "none" },
            {"name": "version", "description": "internal version number", "unit": "none" },
            {"name": "io", "description": "setup, input, output, temp", "unit": "none" },
            {"name": "schema_name", "description": "schema", "unit": "none" },
            {"name": "table_name", "description": "table", "unit": "none" },
            {"name": "script_name", "description": "source", "unit": "none" },
            {"name": "entries", "description": "number of rows", "unit": "none" },
            {"name": "comment", "description": "additional info", "unit": "none" },
            {"name": "user_name", "description": "database user", "unit": "none" },
            {"name": "timestamp", "description": "current time", "unit": "none" },
            {"name": "metadata", "description": "copy of the metadata", "unit": "none" } ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1','setup','model_draft','reeem_scenario_log','database_tables_setup.sql','Update metadata');


-- test table
DROP TABLE IF EXISTS    model_draft.test_table CASCADE;
CREATE TABLE            model_draft.test_table (
    id      serial,
    name    text,
    value   integer,
    geom    geometry,
    CONSTRAINT test_table_pkey PRIMARY KEY (id));

ALTER TABLE             model_draft.test_table OWNER TO reeem_user; 
GRANT SELECT ON TABLE   model_draft.test_table TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.test_table IS '{
"title": "Good title",
"description": "example metadata for example data",
"language": ["eng", "ger", "fre"],
"spatial": {
"location": "none",
"extent": "europe",
"resolution": "100 m" },
"temporal": {
"reference_date": "2017-12-31",
"start": "2017-01-01",
"end": "2017-12-31",
"resolution": "hour" },
"sources": [
{"name": "Website",
"description": "Data website",
"url": "www.website.com",
"license": "tba" ,
"copyright": "tba" },
{"name": "Website",
"description": "Data website",
"url": "www.website.com",
"license": "tba" ,
"copyright": "tba" } ],
"license": {
"id": "GPL-3.0",
"name": "GNU General Public License 3.0",
"version": "3.0",
"url": "https://opensource.org/licenses/GPL-3.0",
"instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute, Share-Alike, Keep open!",
"copyright": "© Reiner Lemoine Institut" },
"contributors": [
{"name": "Joe Nobody",
"email": "joe.nobody@gmail.com",
"date": "2016-06-16",
"comment": "created metadata" },
{"name": "Joe Nobody",
"email": "joe.nobody@gmail.com",
"date": "2016-06-17",
"comment": "updated metadata" } ],
"resources": [
{"name": "model_draft.test_table",
"format": "PostgreSQL",
"fields": [
{"name": "id", "description": "Unique identifier", "unit": "none" },
{"name": "year", "description": "Reference year", "unit": "none" },
{"name": "value", "description": "Example value", "unit": "MW" },
{"name": "geom", "description": "Geometry", "unit": "none" } ] } ],
"metadata_version": "1.3" } ';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1','setup','model_draft','test_table','database_tables_setup.sql',' ');
