/*
Database schema setup

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/utilities/reeem_setup_schema.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


CREATE SCHEMA boundaries; COMMENT ON SCHEMA boundaries IS 'legal land descriptions. examples: political and administrative boundaries'; 
GRANT ALL ON SCHEMA boundaries TO reeem_user WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA boundaries GRANT ALL ON TABLES TO reeem_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA boundaries GRANT ALL ON SEQUENCES TO reeem_user;
GRANT USAGE ON SCHEMA boundaries TO reeem_read WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA boundaries GRANT SELECT ON TABLES TO reeem_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA boundaries GRANT SELECT ON SEQUENCES TO reeem_read;
ALTER SCHEMA boundaries OWNER TO reeem_admin;

CREATE SCHEMA climate; COMMENT ON SCHEMA climate IS 'processes and phenomena of the atmosphere. examples: cloud cover, weather, climate, atmospheric conditions, climate change, precipitation';
GRANT ALL ON SCHEMA climate TO reeem_user WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA climate GRANT ALL ON TABLES TO reeem_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA climate GRANT ALL ON SEQUENCES TO reeem_user;
GRANT USAGE ON SCHEMA climate TO reeem_read WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA climate GRANT SELECT ON TABLES TO reeem_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA climate GRANT SELECT ON SEQUENCES TO reeem_read;
ALTER SCHEMA climate OWNER TO reeem_admin;

CREATE SCHEMA economy; COMMENT ON SCHEMA economy IS 'economic activities, conditions and employment. examples: production, labour, revenue, commerce, industry, tourism and ecotourism, forestry, fisheries, commercial or subsistence hunting, exploration and exploitation of resources such as minerals, oil and gas';
GRANT ALL ON SCHEMA economy TO reeem_user WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA economy GRANT ALL ON TABLES TO reeem_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA economy GRANT ALL ON SEQUENCES TO reeem_user;
GRANT USAGE ON SCHEMA economy TO reeem_read WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA economy GRANT SELECT ON TABLES TO reeem_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA economy GRANT SELECT ON SEQUENCES TO reeem_read;
ALTER SCHEMA economy OWNER TO reeem_admin;

CREATE SCHEMA energy_demand; COMMENT ON SCHEMA energy_demand IS 'consumption and use of energy. examples: peak loads, load curves';
GRANT ALL ON SCHEMA energy_demand TO reeem_user WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA energy_demand GRANT ALL ON TABLES TO reeem_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA energy_demand GRANT ALL ON SEQUENCES TO reeem_user;
GRANT USAGE ON SCHEMA energy_demand TO reeem_read WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA energy_demand GRANT SELECT ON TABLES TO reeem_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA energy_demand GRANT SELECT ON SEQUENCES TO reeem_read;
ALTER SCHEMA energy_demand OWNER TO reeem_admin;

CREATE SCHEMA energy_grid; COMMENT ON SCHEMA energy_grid IS 'energy transmission infrastructure. examples: power lines, substation, pipelines';
GRANT ALL ON SCHEMA energy_grid TO reeem_user WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA energy_grid GRANT ALL ON TABLES TO reeem_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA energy_grid GRANT ALL ON SEQUENCES TO reeem_user;
GRANT USAGE ON SCHEMA energy_grid TO reeem_read WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA energy_grid GRANT SELECT ON TABLES TO reeem_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA energy_grid GRANT SELECT ON SEQUENCES TO reeem_read;
ALTER SCHEMA energy_grid OWNER TO reeem_admin;

CREATE SCHEMA energy_supply; COMMENT ON SCHEMA energy_supply IS 'conversion (generation) of energy. examples: power stations, renewables';
GRANT ALL ON SCHEMA energy_supply TO reeem_user WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA energy_supply GRANT ALL ON TABLES TO reeem_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA energy_supply GRANT ALL ON SEQUENCES TO reeem_user;
GRANT USAGE ON SCHEMA energy_supply TO reeem_read WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA energy_supply GRANT SELECT ON TABLES TO reeem_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA energy_supply GRANT SELECT ON SEQUENCES TO reeem_read;
ALTER SCHEMA energy_supply OWNER TO reeem_admin;

CREATE SCHEMA environment; COMMENT ON SCHEMA environment IS 'environmental resources, protection and conservation. examples: environmental pollution, waste storage and treatment, environmental impact assessment, monitoring environmental risk, nature reserves, landscape';
GRANT ALL ON SCHEMA environment TO reeem_user WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA environment GRANT ALL ON TABLES TO reeem_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA environment GRANT ALL ON SEQUENCES TO reeem_user;
GRANT USAGE ON SCHEMA environment TO reeem_read WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA environment GRANT SELECT ON TABLES TO reeem_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA environment GRANT SELECT ON SEQUENCES TO reeem_read;
ALTER SCHEMA environment OWNER TO reeem_admin;

CREATE SCHEMA model_draft; COMMENT ON SCHEMA model_draft IS 'modelling sandbox, temp tables. examples: ego_grid_loadareas';
GRANT ALL ON SCHEMA model_draft TO reeem_user WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA model_draft GRANT ALL ON TABLES TO reeem_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA model_draft GRANT ALL ON SEQUENCES TO reeem_user;
GRANT USAGE ON SCHEMA model_draft TO reeem_read WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA model_draft GRANT SELECT ON TABLES TO reeem_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA model_draft GRANT SELECT ON SEQUENCES TO reeem_read;
GRANT USAGE ON SCHEMA model_draft TO reeem_pathway WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA model_draft GRANT SELECT ON TABLES TO reeem_pathway;
ALTER DEFAULT PRIVILEGES IN SCHEMA model_draft GRANT SELECT ON SEQUENCES TO reeem_pathway;
ALTER SCHEMA model_draft OWNER TO reeem_admin;

GRANT ALL ON SCHEMA public TO reeem_user WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO reeem_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO reeem_user;
GRANT USAGE ON SCHEMA public TO reeem_read WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO reeem_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON SEQUENCES TO reeem_read;

CREATE SCHEMA reference; COMMENT ON SCHEMA reference IS 'sources, literature';
GRANT ALL ON SCHEMA reference TO reeem_user WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA reference GRANT ALL ON TABLES TO reeem_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA reference GRANT ALL ON SEQUENCES TO reeem_user;
GRANT USAGE ON SCHEMA reference TO reeem_read WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA reference GRANT SELECT ON TABLES TO reeem_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA reference GRANT SELECT ON SEQUENCES TO reeem_read;
ALTER SCHEMA reference OWNER TO reeem_admin;

CREATE SCHEMA scenario; COMMENT ON SCHEMA scenario IS 'scenario data';
GRANT ALL ON SCHEMA scenario TO reeem_user WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA scenario GRANT ALL ON TABLES TO reeem_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA scenario GRANT ALL ON SEQUENCES TO reeem_user;
GRANT USAGE ON SCHEMA scenario TO reeem_read WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA scenario GRANT SELECT ON TABLES TO reeem_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA scenario GRANT SELECT ON SEQUENCES TO reeem_read;
ALTER SCHEMA scenario OWNER TO reeem_admin;

CREATE SCHEMA society; COMMENT ON SCHEMA society IS 'characteristics of society and cultures. examples: settlements, anthropology, archaeology, education, traditional beliefs, manners and customs, demographic data, recreational areas and activities, social impact assessments, crime and justice, census information';
GRANT ALL ON SCHEMA society TO reeem_user WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA society GRANT ALL ON TABLES TO reeem_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA society GRANT ALL ON SEQUENCES TO reeem_user;
GRANT USAGE ON SCHEMA society TO reeem_read WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA society GRANT SELECT ON TABLES TO reeem_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA society GRANT SELECT ON SEQUENCES TO reeem_read;
ALTER SCHEMA society OWNER TO reeem_admin;


-- REEEM game
CREATE SCHEMA game; COMMENT ON SCHEMA game IS 'reeem learning simulation';
GRANT ALL ON SCHEMA game TO reeem_game WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA game GRANT ALL ON TABLES TO reeem_game;
ALTER DEFAULT PRIVILEGES IN SCHEMA game GRANT ALL ON SEQUENCES TO reeem_game;
GRANT USAGE ON SCHEMA game TO reeem_read WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA game GRANT SELECT ON TABLES TO reeem_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA game GRANT SELECT ON SEQUENCES TO reeem_read;
ALTER SCHEMA game OWNER TO reeem_game;

-- REEEM pathway
CREATE SCHEMA pathway; COMMENT ON SCHEMA pathway IS 'reeem pathway diagnostic tool';
GRANT ALL ON SCHEMA pathway TO reeem_pathway WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA pathway GRANT ALL ON TABLES TO reeem_pathway;
ALTER DEFAULT PRIVILEGES IN SCHEMA pathway GRANT ALL ON SEQUENCES TO reeem_pathway;
GRANT USAGE ON SCHEMA pathway TO reeem_read WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA pathway GRANT SELECT ON TABLES TO reeem_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA pathway GRANT SELECT ON SEQUENCES TO reeem_read;
ALTER SCHEMA pathway OWNER TO reeem_pathway;

CREATE SCHEMA IF NOT EXISTS hdb_catalog;
GRANT ALL ON SCHEMA hdb_catalog TO reeem_pathway WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON SCHEMA hdb_catalog TO reeem_pathway;
ALTER SCHEMA hdb_catalog OWNER TO reeem_pathway;

CREATE SCHEMA IF NOT EXISTS hdb_views;
GRANT ALL ON SCHEMA hdb_views TO reeem_pathway WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON SCHEMA hdb_views TO reeem_pathway;
ALTER SCHEMA hdb_views OWNER TO reeem_pathway;

GRANT SELECT ON ALL TABLES IN SCHEMA information_schema TO reeem_pathway;
GRANT SELECT ON ALL TABLES IN SCHEMA pg_catalog TO reeem_pathway;


-- QGIS
ALTER TABLE             public.layer_styles OWNER TO reeem_user; 
GRANT SELECT ON TABLE   public.layer_styles TO reeem_read WITH GRANT OPTION;

ALTER TABLE             public.spatial_ref_sys OWNER TO reeem_user; 
GRANT SELECT ON TABLE   public.spatial_ref_sys TO reeem_read WITH GRANT OPTION;
