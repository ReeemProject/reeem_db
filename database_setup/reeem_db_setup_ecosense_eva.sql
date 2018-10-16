/*
EcoSenseEVA Table Setup

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


-- EcoSenseEVA Output
DROP TABLE IF EXISTS    model_draft.reeem_ecosenseeva_output CASCADE;
CREATE TABLE            model_draft.reeem_ecosenseeva_output (
    "id"            serial NOT NULL,
    "nid"           integer,
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
    CONSTRAINT reeem_ecosenseeva_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_ecosenseeva_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_ecosenseeva_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_ecosenseeva_output IS 
    '{"title": "REEEM EcoSenseEVA Output",
    "description": "Health externalities",
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
        {"name": "TIMES PanEU emisison data", "description": "Uses emission data from TIMES PanEU results for respective pahtways, framework and data version", "url": "none", "license": "none", "copyright": "none"} ],
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
        {"name": "doroschmid", "email": "none", "date": "2018-06-07", "comment": "Update structure and metadata"} ],
    "resources": [
        {"name": "model_draft.reeem_ecosenseeva_output",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Model id", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "region", "description": "Country", "unit": "none"},
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
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_ecosenseeva_output','reeem_db_setup_ecosense.sql',' ');
