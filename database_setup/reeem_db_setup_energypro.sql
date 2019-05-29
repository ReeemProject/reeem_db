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
    "schema"        text,
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
        {"name": "Times2017",
        "description": "TimesPanEU Output data",
        "url": "none",
        "license": "Open Data Commons Attribution License 1.0 (ODC-BY-1.0)",
        "copyright": "© Institut für Energiewirtschaft und Rationelle Energieanwendung (IER) der Universität Stuttgart"},
        {"name": "Hast2018",
        "description": "Transition to carbon neutral energy systems – implications to district heating in cities",
        "url": "none",
        "license": "none",
        "copyright": "© 2018 IEEE"},
        {"name": "Mäkelä2014",
        "description": "Open district heating and marginal cost based heat pricing",
        "url": "none",
        "license": "none",
        "copyright": "© Mäkelä"},
        {"name": "Helistö2017",
        "description": "Sensitivity of electricity prices in energy-only markets with large amounts of zero marginal cost generation",
        "url": "https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=7981893",
        "license": "none",
        "copyright": "© 2017 IEEE"},
        {"name": "BiPRO2013",
        "description": "Support to Member States in improving waste management based on assessment of Member States’ performance",
        "url": "http://ec.europa.eu/environment/waste/framework/pdf/Final%20Report%20_130507.pdf",
        "license": "none",
        "copyright": "© BiPRO GmbH"},
        {"name": "Parliament of Finland2016",
        "description": "Hallituksen esitys eduskunnalle laeiksi nestemäisten polttoaineiden valmisteverosta sekä sähkön ja eräiden polttoaineiden valmisteverosta annettujen lakien liitteiden muuttamisesta",
        "url": "none",
        "license": "CC-BY-4.0",
        "copyright": "© Parliament of Finland"},
        {"name": "European Commission2017",
        "description": "Excise duty tables - Part II Energy products and Electricity",
        "url": "none",
        "license": "none",
        "copyright": "© European Commission"},
        {"name": "Expert opinion2018",
        "description": "Expert opinion",
        "url": "none",
        "license": "none",
        "copyright": "none"}],
    "license":
        {"id": "CC-BY-4.0",
        "name": "Creative Commons Attribution 4.0 International",
        "version": "4.0",
        "url": "http://creativecommons.org/licenses/by/4.0/legalcode",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!",
        "copyright": "© Aalto University"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2018-10-02", "comment": "Create table"},
        {"name": "Ludee", "email": "none", "date": "2018-10-31", "comment": "Update metadata and license"},
        {"name": "4lm", "email": "none", "date": "2019-01-31", "comment": "Alter table, add missing columns"},
        {"name": "4lm", "email": "none", "date": "2019-05-14", "comment": "Add sources"}],
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
    "schema"        text,
    CONSTRAINT reeem_energypro_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_energypro_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_energypro_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_energypro_output IS 
    '{"title": "REEEM EnergyPRO Output",
    "description": "none",
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
        "description": "none",
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
        {"name": "Ludee", "email": "none", "date": "2018-10-31", "comment": "Update metadata and license"},
        {"name": "4lm", "email": "none", "date": "2019-01-31", "comment": "Alter table, add missing columns"},
        {"name": "4lm", "email": "none", "date": "2019-05-29", "comment": "Update metadata"} ],
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
