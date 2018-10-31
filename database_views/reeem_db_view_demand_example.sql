/*
REEEM-DB - View - Energy Demand - Example

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/reeem_db_setup_energypro.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- view
DROP VIEW IF EXISTS model_draft.reeem_db_energydemand_view;
CREATE VIEW         model_draft.reeem_db_energydemand_view AS
    SELECT  id,
            pathway,
            framework,
            version,
            region,
            year,
            value,
            unit,
            aggregation,
            tags,
            updated,
            md.mj AS metadata
    FROM    model_draft.reeem_times_paneu_input,
            (SELECT obj_description('model_draft.reeem_times_paneu_input' ::regclass) ::json AS mj) AS md
    WHERE   (pathway = 'Base' OR pathway = 'HighRES') AND
            version = 'DataV1' AND
            --region = 'SE' AND
            tags @> '"model"=>"times_paneu"'::hstore AND
            tags @> '"field"=>"service_demand"'::hstore AND
            tags @> '"demand_sector"=>"agriculture"'::hstore
    ORDER BY pathway, version, region, year;

ALTER TABLE model_draft.reeem_db_energydemand_view OWNER TO reeem_user; 

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.3.0','view','model_draft','reeem_db_energydemand_view','reeem_db_view_demand_example.sql',' ');
