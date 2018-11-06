/*
EnergyPRO Table Setup

EnergyPRO Input
EnergyPRO Output

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/8"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/reeem_db_setup_energypro.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- EnergyPRO Input
DROP TABLE IF EXISTS    model_draft.reeem_energypro_input CASCADE;
CREATE TABLE            model_draft.reeem_energypro_input (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "region"        text,
    "year"          smallint,
    "field"         text,
    "category"      text,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "tags"          hstore,
    "updated"       timestamp with time zone,
    "source"        text,
    CONSTRAINT reeem_energypro_input_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_energypro_input OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_energypro_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_energypro_input IS 
    '{"title": "REEEM EnergyPRO Input",
    "description": "Optimization of co- and trigeneration projects",
    "language": [ "eng" ],
    "spatial": 
        {"location": "erratic(PL-Warsaw;FI-Helsinki)",
        "extent": "none",
        "resolution": "city"},
    "temporal": 
        {"reference_date": "2020",
        "start": "2020",
        "end": "2050",
        "resolution": "erratic(2020;2030;2050)"},
    "sources": [
        {"name": "TimesPanEU", 
        "description": "Output data", 
        "url": "tba", 
        "license": "tba", 
        "copyright": "tba"},
        {"name": "Hast2017", 
        "description": "tba", 
        "url": "tba", 
        "license": "tba", 
        "copyright": "tba"}],
    "license":
        {"id": "CC-BY-4.0",
        "name": "Creative Commons Attribution 4.0 International",
        "version": "4.0",
        "url": "http://creativecommons.org/licenses/by/4.0/legalcode",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!",
        "copyright": "© Aalto University"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2018-10-02", "comment": "Create table"},
        {"name": "Ludee", "email": "none", "date": "2018-10-31", "comment": "Update metadata and license"} ],
    "resources": [
        {"name": "model_draft.reeem_energypro_input",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Model id", "unit": "none"},
            {"name": "dfid", "description": "Row id", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "region", "description": "Country", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "field", "description": "2. classification", "unit": "none"},
            {"name": "category", "description": "3. classification", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_energypro_input','reeem_db_setup_energypro.sql',' ');



-- EnergyPRO Output
DROP TABLE IF EXISTS    model_draft.reeem_energypro_output CASCADE;
CREATE TABLE            model_draft.reeem_energypro_output (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "region"        text,
    "year"          smallint,
    "month"         smallint,
    "year_month"    text,
    "field"         text,
    "category"      text,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "tags"          hstore,
    "updated"       timestamp with time zone,
    CONSTRAINT reeem_energypro_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_energypro_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_energypro_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_energypro_output IS 
    '{"title": "REEEM EnergyPRO Input",
    "description": "",
    "language": [ "eng" ],
    "spatial": 
        {"location": "erratic(PL-Warsaw;FI-Helsinki)",
        "extent": "none",
        "resolution": "city"},
    "temporal": 
        {"reference_date": "2020",
        "start": "2020",
        "end": "2050",
        "resolution": "erratic(2020;2030;2050)"},
    "sources": [
        {"name": "EnergyPro", 
        "description": "tba", 
        "url": "https://openenergy-platform.org/factsheets/models/147/", 
        "license": "none", 
        "copyright": "EMD International A/S"} ],
    "license":
        {"id": "CC-BY-4.0",
        "name": "Creative Commons Attribution 4.0 International",
        "version": "4.0",
        "url": "http://creativecommons.org/licenses/by/4.0/legalcode",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!",
        "copyright": "© Aalto University"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2018-10-25", "comment": "Create table"},
        {"name": "Ludee", "email": "none", "date": "2018-10-31", "comment": "Update metadata and license"}],
    "resources": [
        {"name": "model_draft.reeem_energypro_output",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Model id", "unit": "none"},
            {"name": "dfid", "description": "Row id", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "region", "description": "Country", "unit": "none"},
            {"name": "month", "description": "Month", "unit": "none"},
            {"name": "field", "description": "2. classification", "unit": "none"},
            {"name": "category", "description": "3. classification", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_energypro_output','reeem_db_setup_energypro.sql',' ');
