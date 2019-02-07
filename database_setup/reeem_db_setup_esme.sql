/*
ESME Table Setup

ESME Input
ESME Output

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/40"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/reeem_db_setup_ecosense.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- ESME Output
DROP TABLE IF EXISTS    model_draft.reeem_esme_input CASCADE;
CREATE TABLE            model_draft.reeem_esme_input (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "scenario"      text,
    "year"          smallint,
    "category"      text,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "tags"          hstore,
    "updated"       timestamp with time zone,
    "source"        text,
    "schema"        text,
    "field"         text,
    "region"        text,
    CONSTRAINT reeem_esme_input_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_esme_input OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_esme_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_esme_input IS 
    '{"title": "REEEM ESME Input",
    "description": "",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "none",
        "resolution": "none"},
    "temporal": 
        {"reference_date": "none",
        "start": "none",
        "end": "none",
        "resolution": "none"},
    "sources": [
        {"name": "none", "description": "none", "url": "none", "license": "none", "copyright": "none"} ],
    "license":
        {"id": "tba",
        "name": "tba",
        "version": "tba",
        "url": "tba",
        "instruction": "tba",
        "copyright": "tba"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2019-01-09", "comment": "Create table and metadata"},
        {"name": "4lm", "email": "none", "date": "2019-02-07", "comment": "Alter table, add missing columns"} ],
    "resources": [
        {"name": "model_draft.reeem_esme_input",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Model id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "scenario", "description": "Model scenario id", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "category", "description": "2. classification", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "source", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_esme_input','reeem_db_setup_esme.sql',' ');


-- ESME Output
DROP TABLE IF EXISTS    model_draft.reeem_esme_output CASCADE;
CREATE TABLE            model_draft.reeem_esme_output (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "scenario"      text,
    "year"          smallint,
    "category"      text,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "tags"          hstore,
    "updated"       timestamp with time zone,
    "source"        text,
    "schema"        text,
    "field"         text,
    "region"        text,
    CONSTRAINT reeem_esme_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_esme_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_esme_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_esme_output IS 
    '{"title": "REEEM ESME Output",
    "description": "Health externalities (unit cost factors) due to air pollution",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "",
        "resolution": ""},
    "temporal": 
        {"reference_date": "",
        "start": "2020",
        "end": "2050",
        "resolution": "10 years"},
    "sources": [
        {"name": "ESME Model", "description": "tba", "url": "https://openenergy-platform.org/factsheets/models/144/", "license": "none", "copyright": "Energy Technologies Institute (ETI), UCL"} ],
    "license":
        {"id": "tba",
        "name": "tba",
        "version": "tba",
        "url": "tba",
        "instruction": "tba",
        "copyright": "tba"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2019-01-09", "comment": "Create table and metadata"},
        {"name": "4lm", "email": "none", "date": "2019-01-31", "comment": "Alter table, add missing columns"} ],
    "resources": [
        {"name": "model_draft.reeem_esme_output",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Model id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "scenario", "description": "Model scenario id", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "category", "description": "2. classification", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "source", "description": "Data source (model)", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_esme_output','reeem_db_setup_esme.sql',' ');
