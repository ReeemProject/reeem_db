/*
EcoSense Table Setup

EcoSense Input (NA)
EcoSense Output

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/32"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/reeem_db_setup_ecosense.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- EcoSense Input
DROP TABLE IF EXISTS    model_draft.reeem_ecosense_input CASCADE;
CREATE TABLE            model_draft.reeem_ecosense_input (
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
    CONSTRAINT reeem_ecosense_input_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_ecosense_input OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_ecosense_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_ecosense_input IS 
    '{"title": "REEEM EcoSense Input",
    "description": "Sources of input data used to assess health and envrionmental impacts due to emissions of air pollutants as provided by the European energy system model TIMES PanEU.",
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
        {"name": "JRC population density grid (disaggregated with Corine land cover 2000)", "description": "gridded population data used in EcoSense", "url": "https://www.eea.europa.eu/data-and-maps/data/population-density-disaggregated-with-corine-land-cover-2000-2", "license": "EEA standard re-use policy (https://www.eea.europa.eu/legal/copyright)", "copyright": "Joint Research Centre (JRC)"},
        {"name": "WHO Data Warehouse", cription": "health data for background disease rates", "url": "https://dw.euro.who.int/", "license": "http://www.euro.who.int/en/home/copyright-notice", "copyright"des": "World Health Organisation, Regional Office for Europe"},
        {"name": "Eurostat mortality database", "description": "health data for background disease rates", "url" : "https://ec.europa.eu/eurostat/web/population-demography-migration-projections/data/database", "license": "https://ec.europa.eu/eurostat/about/policies/copyright", "copyright": "Eurostat"},
        {"name": "Eurostat health care database", "description": "health data for background disease rates", "url" : "https://ec.europa.eu/eurostat/web/health/health-care/data/database", "license": "https://ec.europa.eu/eurostat/about/policies/copyright", "copyright": "Eurostat"},
        {"name": "TIMES PanEU emisison data", "description": "Uses emission data from TIMES PanEU results for respective pahtway, framework and data version", "url": "", "license": "ODC-BY-1.0", "copyright": "© Institut für Energiewirtschaft und Rationelle Energieanwendung (IER) der Universität Stuttgart"} ],
    "license":
        {"id": "ODC-BY-1.0",
        "name": "Open Data Commons Attribution License 1.0",
        "version": "1.0",
        "url": "http://opendatacommons.org/licenses/by",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!"
        "copyright": "© Institut für Energiewirtschaft und Rationelle Energieanwendung (IER) der Universität Stuttgart"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2017-05-09", "comment": "Create table"},
        {"name": "Ludee", "email": "none", "date": "2017-11-08", "comment": "Update structure and metadata"},
        {"name": "Ludee", "email": "none", "date": "2018-04-12", "comment": "Finalize structure and update metadata"},
        {"name": "doroschmid", "email": "none", "date": "2018-06-07", "comment": "Update structure and metadata"},
        {"name": "doroschmid", "email": "none", "date": "2019-01-31", "comment": "Update metadata"},
        {"name": "4lm", "email": "none", "date": "2019-01-31", "comment": "Update structure and metadata"} ],
    "resources": [
        {"name": "model_draft.reeem_ecosense_input",
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
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_ecosense_input','reeem_db_setup_ecosense.sql',' ');


-- EcoSense Output
DROP TABLE IF EXISTS    model_draft.reeem_ecosense_output CASCADE;
CREATE TABLE            model_draft.reeem_ecosense_output (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "region"        text,
    "region_2"      text,
    "year"          smallint,
    "category"      text,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "tags"          hstore,
    "updated"       timestamp with time zone,
    "schema"        text,
    "field"         text,
    CONSTRAINT reeem_ecosense_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_ecosense_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_ecosense_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_ecosense_output IS 
    '{"title": "REEEM EcoSense Output",
    "description": "Impacts on human health and biodiversity due to air pollution. Health impacts are stated in ''Disability adjusted lifeyears (DALY)'' and in terms of external costs atributed to countries following the ''Polluter Pays Principle''. Impacts on biodiverstiy are only given in monetary terms. All impacts are estimated based on emissions of air pollutants as provided by TIMES PanEU, to which the contained information about Pathway, Framework and Data version refer to.",
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
        {"name": "EcoSense", "description": "EcoSense is an integrated impact assessment model following the Impact Pathway Appraoch. Assessment of external costs and health impacts in Europe due to air pollution.", "url": "http://ecosenseweb.ier.uni-stuttgart.de/", "license": "proprietary", "copyright": "Institut für Energiewirtschaft und Rationelle Energieanwendung (IER) der Universität Stuttgart"},
        {"name": "OEP Model Factsheet", "description": "", "url": "https://openenergy-platform.org/factsheets/models/146/", "license": "none", "copyright": "none"} ],
    "license":
        {"id": "ODC-BY-1.0",
        "name": "Open Data Commons Attribution License 1.0",
        "version": "1.0",
        "url": "http://opendatacommons.org/licenses/by",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!",
        "copyright": "© Institut für Energiewirtschaft und Rationelle Energieanwendung (IER) der Universität Stuttgart"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2017-05-09", "comment": "Create table"},
        {"name": "Ludee", "email": "none", "date": "2017-11-08", "comment": "Update structure and metadata"},
        {"name": "Ludee", "email": "none", "date": "2018-04-12", "comment": "Finalize structure and update metadata"},
        {"name": "doroschmid", "email": "none", "date": "2018-06-07", "comment": "Update structure and metadata"},
        {"name": "doroschmid", "email": "none", "date": "2018-11-08", "comment": "Update metadata"},
        {"name": "Ludee", "email": "none", "date": "2019-10-22", "comment": "Update metadata sources"},
        {"name": "doroschmid", "email": "none", "date": "2019-01-31", "comment": "Update metadata"},
        {"name": "4lm", "email": "none", "date": "2019-01-31", "comment": "Alter table, add missing columns"} ],
    "resources": [
        {"name": "model_draft.reeem_ecosense_output",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Model id", "unit": "none"},
            {"name": "dfid", "description": "Row id", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "region", "description": "Country (responsible for impacts)", "unit": "none"},
            {"name": "region_2", "description": "Country (where impacts occur)", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "category", "description": "2. classification", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_ecosense_output','reeem_db_setup_ecosense.sql',' ');
