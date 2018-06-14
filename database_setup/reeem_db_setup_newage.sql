/*
NEWAGE Table Setup

NEWAGE Output

https://github.com/ReeemProject/reeem_db/issues/12

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Huelk"
*/


-- NEWAGE Output
DROP TABLE IF EXISTS    model_draft.reeem_newage_output CASCADE;
CREATE TABLE            model_draft.reeem_newage_output (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "region"        text,
    "scenario"      text,
    "year"          smallint,
    "category"      text,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "tags"          hstore,
    "updated"       timestamp with time zone,
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
        "extent": "gloabal",
        "resolution": "country"},
    "temporal": 
        {"reference_date": "none",
        "start": "2011",
        "end": "2050",
        "resolution": "5 years"},
    "sources": [
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""} ],
    "license": 
        {"id": "tba",
        "name": "tba",
        "version": "tba",
        "url": "tba",
        "instruction": "tba",
        "copyright": "tba"},
    "contributors": [
        {"name": "Ludwig Hülk", "email": "ludwig.huelk@rl-institut.de", "date": "2017-07-24", "comment": "Create table"} ],
    "resources": [
        {"name": "model_draft.reeem_newage_output",        
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "unique identifier", "unit": "" },
            {"name": "version", "description": "internal version number", "unit": "" },
            {"name": "nid", "description": "row id", "unit": "" },
            {"name": "table", "description": "table name", "unit": "" },
            {"name": "region", "description": "country or region", "unit": "" },
            {"name": "year", "description": "year", "unit": "" },
            {"name": "value", "description": "value", "unit": "" },
            {"name": "unit", "description": "unit", "unit": "" },
            {"name": "updated", "description": "timestamp", "unit": "" } ] } ],
    "metadata_version": "1.3"}';

SELECT obj_description('model_draft.reeem_newage_output' ::regclass) ::json;

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1','setup','model_draft','reeem_newage_output','database_setup_times_paneu.sql',' ');
