/*
REEEM pathway definition

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
*/


-- REEEM pathways
DROP TABLE IF EXISTS    model_draft.reeem_pathways CASCADE;
CREATE TABLE            model_draft.reeem_pathways (
    id          serial NOT NULL,
    version     text,
    pathway     text,
    description text,
    updated     timestamp with time zone,
    CONSTRAINT reeem_pathways_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_pathways OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_pathways TO reeem_read WITH GRANT OPTION;

-- metadata template
COMMENT ON TABLE model_draft.reeem_pathways IS 
    '{"title": "",
    "description": "",
    "language": [ "eng", "ger" ],
    "spatial": 
        {"location": "",
        "extent": "",
        "resolution": ""},
    "temporal": 
        {"reference_date": "",
        "start": "",
        "end": "",
        "resolution": ""},
    "sources": [
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""},
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""} ],
    "license":
        {"id": "",
        "name": "",
        "version": "",
        "url": "",
        "instruction": "",
        "copyright": ""},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2017--", "comment": "Create table"},
        {"name": "", "email": "", "date": "", "comment": ""} ],
    "resources": [
        {"name": "model_draft.reeem_pathways",        
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "version", "description": "REEEM version number", "unit": "none"},
            {"name": "pathway", "description": "Pathway name", "unit": "none"},
            {"name": "description", "description": "Description", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1.0','setup','model_draft','reeem_pathways','reeem_db_pathways.sql',' ');


-- insert pathways
INSERT INTO model_draft.reeem_pathways (version,pathway,description,updated) VALUES
    ('v0.1.0', 
    'BASE_TI1', 
    'Base pathway:
    - By 2030, 43% decarbonisation target for the ETS sectors in the EU as a whole, compared to 2005 levels.
    - By 2050, 83% decarbonisation target for the ETS sectors in the EU as a whole, compared to 2005 levels.
    - Individual targets for each country for the non-ETS sectors as indicated here.
    - No targets on renewable energy share.
    - GDP and population growth according to The 2015 Ageing Report.
    - Electricity networks development according to the Ten-Year Network Development Plan 2016.
    - Techno-economic characteristics of selected storage technologies according to the First Technology Roadmap. Assumptions already collected on the Input Tables of TIMES and on the REEEM Database.', 
    now() ),
    ('v0.1.0', 
    'BASE_TI1_P1', 
    'Base pathways plus 1:
    - Same assumptions as the base pathway.
    - In addition: nationally determined renewable share in gross final consumption of energy, as indicated here.', 
    now() ),
    ('v0.1.0', 
    'BASE_TI1_P2', 
    'Base pathways plus 1:
    - Same assumptions as BASE_TI1_P1.
    - In addition, cost breakthrough in Lithium Air Technology, as indicated here.', 
    now() );
