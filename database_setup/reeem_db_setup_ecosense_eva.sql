/*
EcoSenseEVA Table Setup

EcoSenseEVA Input (NA)
EcoSenseEVA Output

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/7"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/reeem_db_setup_ecosense.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- EcoSenseEVA Input
DROP TABLE IF EXISTS    model_draft.reeem_ecosenseeva_input CASCADE;
CREATE TABLE            model_draft.reeem_ecosenseeva_input (
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
    CONSTRAINT reeem_ecosenseeva_input_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_ecosenseeva_input OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_ecosenseeva_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_ecosenseeva_input IS 
    '{"title": "REEEM EcoSenseEVA Input",
    "description": "Data implemented in the models to estimate exposure to air pollution and associated health impacts",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Europe",
        "resolution": "Country, grid"},
    "temporal": 
        {"reference_date": "",
        "start": "",
        "end": "",
        "resolution": ""},
    "sources": [
        {"name": "JRC population density grid (disaggregated with Corine land cover 2000)", "description": "gridded population data used in EcoSense", "url": "https://www.eea.europa.eu/data-and-maps/data/population-density-disaggregated-with-corine-land-cover-2000-2", "license": "EEA standard re-use policy (https://www.eea.europa.eu/legal/copyright)", "copyright": "Joint Research Centre (JRC)"},
        {"name": "Eurostat population grid 2011", "description": "gridded population data used in EVA", "url": "https://ec.europa.eu/eurostat/web/gisco/geodata/reference-data/population-distribution-demography/geostat#geostat11", "license": "https://ec.europa.eu/eurostat/web/gisco/geodata/reference-data/population-distribution-demography", "copyright": "Eurostat, European Forum for Geography and Statistics (EFGS)"},
        {"name": "WHO Data Warehouse", "description": "health data for background disease rates", "url": "https://dw.euro.who.int/", "license": "http://www.euro.who.int/en/home/copyright-notice", "copyright": "World Health Organisation, Regional Office for Europe"},
        {"name": "Eurostat mortality database", "description": "health data for background disease rates", "url" : "https://ec.europa.eu/eurostat/web/population-demography-migration-projections/data/database", "license": "https://ec.europa.eu/eurostat/about/policies/copyright", "copyright": "Eurostat"},
        {"name": "Eurostat health care database", "description": "health data for background disease rates", "url" : "https://ec.europa.eu/eurostat/web/health/health-care/data/database", "license": "https://ec.europa.eu/eurostat/about/policies/copyright", "copyright": "Eurostat"},
        {"name": "EMEP/CEIP 2017 Present state of emission data", "description": "Emissions (2013) used to derive unit cost factors", "url": "http://www.ceip.at/ms/ceip_home1/ceip_home/webdab_emepdatabase/emissions_emepmodels/", "license": "", "copyright": "Centre on Emission Inventories and Projections (CEIP)"}],
    "license":
        {"id": "ODC-BY-1.0",
        "name": "Open Data Commons Attribution License 1.0",
        "version": "1.0",
        "url": "http://opendatacommons.org/licenses/by",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!",
        "copyright": "© Institut für Energiewirtschaft und Rationelle Energieanwendung (IER) der Universität Stuttgart / Departement of Environmental Science, Aarhus University"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2017-05-09", "comment": "Create table"},
        {"name": "Ludee", "email": "none", "date": "2017-11-08", "comment": "Update structure and metadata"},
        {"name": "Ludee", "email": "none", "date": "2018-04-12", "comment": "Finalize structure and update metadata"},
        {"name": "doroschmid", "email": "none", "date": "2018-06-07", "comment": "Update structure and metadata"},
        {"name": "doroschmid", "email": "none", "date": "2019-01-31", "comment": "Update structure and metadata"},
        {"name": "4lm", "email": "none", "date": "2019-01-31", "comment": "Update structure and metadata"} ],
    "resources": [
        {"name": "model_draft.reeem_ecosenseeva_input",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Parameter ID", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
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
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "source", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_ecosenseeva_input','reeem_db_setup_ecosense_eva.sql',' ');


-- EcoSenseEVA Output
DROP TABLE IF EXISTS    model_draft.reeem_ecosenseeva_output CASCADE;
CREATE TABLE            model_draft.reeem_ecosenseeva_output (
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
    "source"        text,
    "schema"        text,
    "field"         text,
    CONSTRAINT reeem_ecosenseeva_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_ecosenseeva_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_ecosenseeva_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_ecosenseeva_output IS 
    '{"title": "REEEM EcoSenseEVA Output",
    "description": "Unit cost factors for health impacts due to air pollution in Europe to be used in energy system models. Cost factors are given in €/kg emissions released for Particulate Matter (PM2.5, PM10), SO2, NOX, NMVOC and NH3 and are estimated following the ''Polluter Pays Principle''",
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
         {"name": "EcoSense", "description": "EcoSense is an integrated impact assessment model following the Impact Pathway Appraoch. Assessment of external costs and health impacts in Europe due to air pollution.", "url": "http://ecosenseweb.ier.uni-stuttgart.de/", "license": "proprietary", "copyright": "Institut für Energiewirtschaft und Rationelle Energieanwendung (IER) der Universität Stuttgart"},
         {"name": "OEP Model Factsheet (EcoSense)", "description": "", "url": "https://openenergy-platform.org/factsheets/models/146/", "license": "none", "copyright": "none"},
         {"name": "EVA", "description": "Economic valuation of Air Pollution. EVA is an integrated impact assessment model to estimate health impacts and associated costs due to air pollution.", "url": "https://openenergy-platform.org/factsheets/models/153/", "license": "proprietary", "copyright": "Departement of Environmental Science, Aarhus University"}],
    "license":
        {"id": "ODC-BY-1.0",
        "name": "Open Data Commons Attribution License 1.0",
        "version": "1.0",
        "url": "http://opendatacommons.org/licenses/by",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!",
        "copyright": "© Institut für Energiewirtschaft und Rationelle Energieanwendung (IER) der Universität Stuttgart / Departement of Environmental Science, Aarhus University"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2017-05-09", "comment": "Create table"},
        {"name": "Ludee", "email": "none", "date": "2017-11-08", "comment": "Update structure and metadata"},
        {"name": "Ludee", "email": "none", "date": "2018-04-12", "comment": "Finalize structure and update metadata"},
        {"name": "doroschmid", "email": "none", "date": "2018-06-07", "comment": "Update structure and metadata"},
        {"name": "doroschmid", "email": "none", "date": "2018-11-08", "comment": "Update metadata"},
        {"name": "doroschmid", "email": "none", "date": "2019-01-31", "comment": "Update metadata"},
        {"name": "4lm", "email": "none", "date": "2019-01-31", "comment": "Alter table, add missing columns"} ],
    "resources": [
        {"name": "model_draft.reeem_ecosenseeva_output",
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
            {"name": "category", "description": "2. classification", "unit": "none"},
            {"name": "indicator", "description": "Parameter name (pollutant)", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "source", "description": "Data source (model)", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_ecosenseeva_output','reeem_db_setup_ecosense_eva.sql',' ');
