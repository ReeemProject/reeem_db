/*
NEWAGE Table Setup

NEWAGE Output

https://github.com/ReeemProject/reeem_db/issues/12

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Huelk"
*/


-- NEWAGE Input
DROP TABLE IF EXISTS    model_draft.reeem_newage_input CASCADE;
CREATE TABLE            model_draft.reeem_newage_input (
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
    CONSTRAINT reeem_newage_input_pkey PRIMARY KEY (id) );
    
ALTER TABLE        model_draft.reeem_newage_input OWNER TO reeem_user;
GRANT SELECT ON TABLE    model_draft.reeem_newage_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_newage_input IS '{
    "title": "NEWAGE Input",
    "description": "Example data from NEWAGE model",
    "language": [ "eng" ],
    "spatial":
        {"location": "none",
        "extent": "global",
        "resolution": "country"},
    "temporal":
        {"reference_date": "none",
        "start": "2011",
        "end": "2050",
        "resolution": "5 years"},
    "sources": [
        {"name": "GTAP 9", "description": "Global data base describing bilateral trade patterns, production, consumption and intermediate use of commodities and services", "url": "https://www.gtap.agecon.purdue.edu/databases/v9/default.asp", "license": "proprietary", "copyright": "© 2019, Purdue University. All rights reserved. "},
        {"name": "Electricity Information 2013", "description": "It provides comprehensive statistical details on overall energy consumption, economic indicators, electricity and heat production by energy form and plant type, electricity imports and exports, sectoral energy and electricity consumption, as well as prices for electricity and electricity input fuels for each country and regional aggregate.", "url": "https://doi.org/10.1787/electricity-2013-en", "license": "none", "copyright": "©OECD. All rights reserved."},
        {"name": "EconMap 2050", "description": "EconMap is the database developed by the CEPII in 2010 to picture the world economy in the long term. EconMap was formerly known as Baseline. It presents projections for total population, employment according to education level, GDP and other parameters for 167 countries", "url": "http://www.cepii.fr/CEPII/en/bdd_modele/presentation.asp?id=11", "license": "Licence Ouverte/ Open Licence", "copyright": "CEPII. All rights reserved"},
        {"name": "CO2 Emissions Path", "description": "CO2 emission targets for NEWAGE regions, sectors and scenarios", "url": "none", "license": "none", "copyright": "Institut für Energiewirtschaft und Rationelle Energieanwendung (IER) der Universität Stuttgart"} ],
    "license":
        {"id": "none",
        "name": "none",
        "version": "none",
        "url": "none",
        "instruction": "none",
        "copyright": "none"},
    "contributors": [
        {"name": "4lm", "email": "none", "date": "2019-01-31", "comment": "Update structure and add metadata"} ],
    "resources": [
        {"name": "model_draft.reeem_newage_input",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Parameter ID", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "schema", "description": "1. classification", "unit": "none"},
            {"name": "field", "description": "2. classification", "unit": "none"},
            {"name": "category", "description": "3. classification", "unit": "none"},
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
SELECT scenario_log('REEEM','v0.1.0','setup','model_draft','reeem_newage_input','database_setup_newage.sql',' ');


-- NEWAGE Output
DROP TABLE IF EXISTS    model_draft.reeem_newage_output CASCADE;
CREATE TABLE            model_draft.reeem_newage_output (
    "id"            serial NOT NULL,
    "rid"           integer,
    "nid"           integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "scenario"      text,
    "region"        text,
    "field"         text,
    "category"      text,
    "year"          smallint,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "tags"          hstore,
    "updated"       timestamp with time zone,
    "schema"        text,
    CONSTRAINT reeem_newage_output_pkey PRIMARY KEY (id) );
    
ALTER TABLE        model_draft.reeem_newage_output OWNER TO reeem_user;
GRANT SELECT ON TABLE    model_draft.reeem_newage_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_newage_output IS '{
    "title": "NEWAGE Output",
    "description": "Example data from NEWAGE model",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "global",
        "resolution": "country"},
    "temporal": 
        {"reference_date": "none",
        "start": "2011",
        "end": "2050",
        "resolution": "5 years"},
    "sources": [
        {"name": "newage", "description": "the newage (national european worldwide applied general equilibrium) model is a global, recursive-dynamic computable general equilibrium (cge) model with a detailed specification of the energy sector", "url": "https://www.ier.uni-stuttgart.de/forschung/modelle/NEWAGE/index_en.html", "license": "proprietary", "copyright": "Institut für Energiewirtschaft und Rationelle Energieanwendung (IER) der Universität Stuttgart"} ],
    "license": 
        {"id": "CC-BY-4.0",
        "name": "Creative Commons Attribution 4.0 International",
        "version": "4.0",
        "url": "http://creativecommons.org/licenses/by/4.0/legalcode",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!",
        "copyright": "© Institut für Energiewirtschaft und Rationelle Energieanwendung (IER) der Universität Stuttgart"},
    "contributors": [
        {"name": "Ludwig Hülk", "email": "ludwig.huelk@rl-institut.de", "date": "2017-07-24", "comment": "Create table"},
        {"name": "4lm", "email": "none", "date": "2019-01-31", "comment": "Alter table, add missing columns"} ],
    "resources": [
        {"name": "model_draft.reeem_newage_output",        
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "scenario", "description": "Scenario", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "schema", "description": "1. classification", "unit": "none"},
            {"name": "field", "description": "2. classification", "unit": "none"},
            {"name": "category", "description": "3. classification", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.1.0','setup','model_draft','reeem_newage_output','database_setup_newage.sql',' ');
