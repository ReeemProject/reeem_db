/*
OSeMOSYS MESCA Table Setup

OSeMOSYS MESCA Input
OSeMOSYS MESCA Output

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/45"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/reeem_db_setup_osemosys_mesca.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- OSeMOSYS MESCA input
DROP TABLE IF EXISTS    model_draft.reeem_osemosys_mesca_input CASCADE;
CREATE TABLE            model_draft.reeem_osemosys_mesca_input (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
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
    CONSTRAINT reeem_osemosys_mesca_input_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_osemosys_mesca_input OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_osemosys_mesca_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_osemosys_mesca_input IS 
    '{"title": "REEEM OSeMOSYS MESCA Input",
    "description": "Input parameters: Costs, Lifetime, Efficiency, Final demand",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "EE, FI, LT, LV",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2015",
        "start": "2015",
        "end": "2050",
        "resolution": "1 years"},
    "sources": [
        {"name": "TIMES PanEU", "description": "TIMES is an energy system model generator which is a further development of the model generators MARKAL and EFOM-ENV, written in GAMS. TIMES is a bottom-up linear optimization model based on a technical approach. The aim of the model is to optimize the energy system cost according to the given energy demands, energy technologies, and policy requirements. The Pan-European TIMES energy system model (TIMES PanEU) is a 30 region partial equilibrium energy system model. The model covers the EU-28 countries, with addition of Norway and Switzerland. The base year is 2010 and the time horizon ends in 2050. The current structure accounts for 12 time slices, 4 seasonal and 3 daily.  The model is split in 5-year time steps. Both greenhouse gas emissions (CO2, CH4, N2O, SF6) and local air pollutant emissions (SO2, CO, NOx, NMVOC, PM10, PM2.5) are included. TIMES PanEU contains the country specific data covering all the sectors related to energy supply and demand. The system commences from the potential of different energy sources in a particular country and includes public and industrial generation of electricity, industry, agriculture, refineries, inventory power stations and the end-use service demands such as heating, lighting and transportation.", "url": "http://openenergyplatform.org/factsheets/models/41/", "license": "Open Data Commons Attribution License 1.0 (ODC-BY-1.0)", "copyright": "© Institut für Energiewirtschaft und Rationelle Energieanwendung (IER) der Universität Stuttgart"},
	      {"name": "MESSAGE", "description": "Model for Energy Supply Strategy Alternatives and their General Environmental Impacts", "url": "http://www.iiasa.ac.at/web/home/research/researchPrograms/Energy/MESSAGE.en.html", "license": "none", "copyright": "none"},
        {"name": "Technology data catalogue, 2018", "description": "Technology Data provides information about technology, economy and environment for a number of energy installations and are among other things used by the Danish Energy Agency for energy projections.", "url": "https://ens.dk/en/our-services/projections-and-models/technology-data", "license": "none", "copyright": "none"} ],
    "license":
        {"id": "CC-BY-4.0",
        "name": "Creative Commons Attribution 4.0 International",
        "version": "4.0",
        "url": "http://creativecommons.org/licenses/by/4.0/legalcode",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!",
        "copyright": "© Lithuanian Energy Institute"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2019-01-28", "comment": "Create table and metadata"},
        {"name": "Linas", "email": "none", "date": "2019-01-29", "comment": "Update metadata"},
        {"name": "4lm", "email": "none", "date": "2019-06-04", "comment": "Update sources in metadata"} ],
    "resources": [
        {"name": "model_draft.reeem_osemosys_mesca_input",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
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
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_osemosys_mesca_input','reeem_db_setup_osemosys_mesca.sql',' ');


-- OSeMOSYS MESCA Output
DROP TABLE IF EXISTS    model_draft.reeem_osemosys_mesca_output CASCADE;
CREATE TABLE            model_draft.reeem_osemosys_mesca_output (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
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
    CONSTRAINT reeem_osemosys_mesca_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_osemosys_mesca_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_osemosys_mesca_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_osemosys_mesca_output IS 
    '{"title": "REEEM OSeMOSYS MESCA Output",
    "description": "Model provides Energy Security Coefficient (ESC)",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "EE, FI, LT, LV",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2015",
        "start": "2015",
        "end": "2050",
        "resolution": "1 years"},
    "sources": [
        {"name": "OSeMOSYS MESCA", "description": "Model provides Energy Security Coefficient (ESC)", "url": "none", "license": "none", "copyright": "none"} ],
    "license":
        {"id": "CC-BY-4.0",
        "name": "Creative Commons Attribution 4.0 International",
        "version": "4.0",
        "url": "http://creativecommons.org/licenses/by/4.0/legalcode",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!",
        "copyright": "© Lithuanian Energy Institute"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2019-01-28", "comment": "Create table and metadata"},
        {"name": "Linas", "email": "none", "date": "2019-01-29", "comment": "Update metadata"} ],
    "resources": [
        {"name": "model_draft.reeem_osemosys_mesca_output",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
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
            {"name": "updated", "description": "Timestamp", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_osemosys_mesca_output','reeem_db_setup_osemosys_mesca.sql',' ');
