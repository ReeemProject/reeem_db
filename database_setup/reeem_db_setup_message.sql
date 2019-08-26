/*
MESSAGE Table Setup

MESSAGE Input
MESSAGE Output


__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/11"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/reeem_db_setup_message.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- MESSAGE Input
DROP TABLE IF EXISTS    model_draft.reeem_message_input CASCADE;
CREATE TABLE            model_draft.reeem_message_input (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
    "internal_id"   text,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "schema"        text,
    "category"      text,
    "tags"          hstore,
    "field"         text,
    "region"        text,
    "year"          smallint,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "updated"       timestamp with time zone,
    "source"        text,
    CONSTRAINT reeem_message_input_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_message_input OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_message_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_message_input IS '{
    "title": "REEEM MESSAGE Input",
    "description": "Input parameters: Service Demands, Fuel Prices, Potentials",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Europe",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2015",
        "start": "2015",
        "end": "2060",
        "resolution": "1 year"},
    "sources": [
        {"name": "Lietuvos energetikos sektoriaus pletros tyrimas", "description": "Report discusses energy supply options in Lithuania and overviews other countries in the region", "url": "http://www.lei.lt/_img/_up/File/atvir/2016/NES/2-Technine_ekonomine_energetikos_sektoriaus_pletros_analize-2015.11.16.pdf", "license": "none", "copyright": "© 2015, Lithuanian Energy Institute. All rights reserved. "},
        {"name": "Technology Data for Energy Plants for Electricity and District heating generation", "description": "Technology data catalogue", "url": "https://ens.dk/sites/ens.dk/files/Analyser/technology_data_catalogue_for_el_and_dh_-_aug_2016_upd_oct18.pdf", "license": "none", "copyright": "Danish Energy Agency"},
        {"name": "NORDPOOL", "description": "Nordpool market data", "url": "https://www.nordpoolgroup.com/Market-data1#/", "license": "none", "copyright": "© Nord Pool 2017"},
        {"name": "Eurostat", "description": "Large statistical database that includes aggregated capacities, historical energy production, import and export flows, etc., ", "url": "https://ec.europa.eu/eurostat/data/database", "license": "free re-use, both for non-commercial and commercial purposes (https://ec.europa.eu/eurostat/about/policies/copyright)", "copyright": "© European Union, 1995 - today"} ],
    "license":
        {"id": "CC-BY-4.0",
        "name": "Creative Commons Attribution 4.0 International",
        "version": "4.0",
        "url": "http://creativecommons.org/licenses/by/4.0/legalcode",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!",
        "copyright": "© Lithuanian Energy Institute"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2019-01-22", "comment": "Create table and metadata"} ],
    "resources": [
        {"name": "model_draft.reeem_message_input",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "schema", "description": "1. classification", "unit": "none"},
            {"name": "category", "description": "2. classification", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "field", "description": "Old classification", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "source", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.1','setup','model_draft','reeem_message_input','reeem_db_setup_message.sql',' ');


-- MESSAGE Output
DROP TABLE IF EXISTS    model_draft.reeem_message_output CASCADE;
CREATE TABLE            model_draft.reeem_message_output (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "schema"        text,
    "category"      text,
    "tags"          hstore,
    "field"         text,
    "region"        text,
    "year"          smallint,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "updated"       timestamp with time zone,
    CONSTRAINT reeem_message_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_message_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_message_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_message_output IS '{
    "title": "REEEM MESSAGE Output",
    "description": "Output parameters: ",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Europe (EU28+NO+CH)",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2015",
        "start": "2015",
        "end": "2050",
        "resolution": "1 year"},
    "sources": [
        {"name": "MESSAGE", "description": "Model documentation", "url": "none", "license": "none", "copyright": "none"} ],
    "license":
        {"id": "CC-BY-4.0",
        "name": "Creative Commons Attribution 4.0 International",
        "version": "4.0",
        "url": "http://creativecommons.org/licenses/by/4.0/legalcode",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!",
        "copyright": "© Lithuanian Energy Institute"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2019-01-22", "comment": "Create table and metadata"} ],
    "resources": [
        {"name": "model_draft.reeem_message_output",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "schema", "description": "1. classification", "unit": "none"},
            {"name": "category", "description": "2. classification", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "field", "description": "Old classification", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.1','setup','model_draft','reeem_message_output','reeem_db_setup_message.sql',' ');
