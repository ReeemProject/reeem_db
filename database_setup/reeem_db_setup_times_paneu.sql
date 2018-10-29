/*
TIMES PanEU Table Setup

TIMES PanEU Input
TIMES PanEU Output

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/4"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/reeem_db_setup_times_paneu.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- TIMES PanEU input
DROP TABLE IF EXISTS    model_draft.reeem_times_paneu_input CASCADE;
CREATE TABLE            model_draft.reeem_times_paneu_input (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "region"        text,
    "year"          smallint,
    "category"      text,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "tags"          hstore,
    "updated"       timestamp with time zone,
    CONSTRAINT reeem_times_paneu_input_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_times_paneu_input OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_times_paneu_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_times_paneu_input IS 
    '{"title": "REEEM Times PanEU Input",
    "description": "Input parameters: Service Demands, Fuel Prices, Potentials",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Europe",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2010",
        "start": "2015",
        "end": "2050",
        "resolution": "5 years"},
    "sources": [
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""},
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""} ],
    "license":
        {"id": "tba",
        "name": "tba",
        "version": "tba",
        "url": "tba",
        "instruction": "tba",
        "copyright": "tba"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2016-12-01", "comment": "Create table"},
        {"name": "Ludee", "email": "none", "date": "2017-01-18", "comment": "Update metadata"},
        {"name": "Ludee", "email": "none", "date": "2017-07-24", "comment": "Update metadata"},
        {"name": "Ludee", "email": "none", "date": "2017-11-02", "comment": "Update structure"},
        {"name": "Ludee", "email": "none", "date": "2017-11-06", "comment": "Include pathway"},
        {"name": "Ludee", "email": "none", "date": "2018-01-30", "comment": "New naming structure"},
        {"name": "Ludee", "email": "none", "date": "2018-02-27", "comment": "Simplify structure"} ],
    "resources": [
        {"name": "model_draft.reeem_times_paneu_input",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
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
SELECT scenario_log('REEEM','v0.1.0','setup','model_draft','reeem_times_paneu_input','reeem_db_setup_times_paneu.sql',' ');


-- TIMES PanEU Output
DROP TABLE IF EXISTS    model_draft.reeem_times_paneu_output CASCADE;
CREATE TABLE            model_draft.reeem_times_paneu_output (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "region"        text,
    "year"          smallint,
    "category"      text,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "tags"          hstore,
    "updated"       timestamp with time zone,
    CONSTRAINT reeem_times_paneu_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_times_paneu_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_times_paneu_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_times_paneu_output IS 
    '{"title": "REEEM Times PanEU Output",
    "description": "Energy Consumption, Installed Capacities, Electricity Production, Heat Production, Fuel Input, Emissions, Mobility, Electricity Exchange",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Europe",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2010",
        "start": "2010",
        "end": "2050",
        "resolution": "5 years"},
    "sources": [
        {"name": "TIMES PanEU", "description": "TIMES is an energy system model generator which is a further development of the model generators MARKAL and EFOM-ENV, written in GAMS. TIMES is a bottom-up linear optimization model based on a technical approach. The aim of the model is to optimize the energy system cost according to the given energy demands, energy technologies, and policy requirements. The Pan-European TIMES energy system model (TIMES PanEU) is a 30 region partial equilibrium energy system model. The model covers the EU-28 countries, with addition of Norway and Switzerland. The base year is 2010 and the time horizon ends in 2050. The current structure accounts for 12 time slices, 4 seasonal and 3 daily.  The model is split in 5-year time steps. Both greenhouse gas emissions (CO2, CH4, N2O, SF6) and local air pollutant emissions (SO2, CO, NOx, NMVOC, PM10, PM2.5) are included. TIMES PanEU contains the country specific data covering all the sectors related to energy supply and demand. The system commences from the potential of different energy sources in a particular country and includes public and industrial generation of electricity, industry, agriculture, refineries, inventory power stations and the end-use service demands such as heating, lighting and transportation.", "url": "http://openenergyplatform.org/factsheets/models/41/", "license": "none", "copyright": "none"} ],
    "license":
        {"id": "ODC-BY-1.0",
        "name": "Open Data Commons Attribution License 1.0",
        "version": "1.0",
        "url": "http://opendatacommons.org/licenses/by",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!",
        "copyright": "© Institut für Energiewirtschaft und Rationelle Energieanwendung (IER) der Universität Stuttgart"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2016-12-01", "comment": "Create table"},
        {"name": "Ludee", "email": "none", "date": "2017-01-18", "comment": "Update metadata"},
        {"name": "Ludee", "email": "none", "date": "2017-07-24", "comment": "Update metadata"},
        {"name": "Ludee", "email": "none", "date": "2017-11-02", "comment": "Update structure"},
        {"name": "Ludee", "email": "none", "date": "2017-11-06", "comment": "Include pathway"},
        {"name": "Ludee", "email": "none", "date": "2018-01-30", "comment": "New naming structure"},
        {"name": "Ludee", "email": "none", "date": "2018-02-27", "comment": "Simplify structure"},
        {"name": "Ludee", "email": "none", "date": "2018-03-15", "comment": "Add license"},
        {"name": "Ludee", "email": "none", "date": "2018-10-08", "comment": "Add source"}],
    "resources": [
        {"name": "model_draft.reeem_times_paneu_output",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
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
SELECT scenario_log('REEEM','v0.1.0','setup','model_draft','reeem_times_paneu_output','reeem_db_setup_times_paneu.sql',' ');
