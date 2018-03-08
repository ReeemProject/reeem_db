/*
Pathways views

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_views/reeem_db_view_pathways.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/

-- pathways
WITH    times_i AS (
    SELECT  'times_paneu_input' AS name, pathway
    FROM    model_draft.reeem_times_paneu_input
    GROUP BY pathway),
        times_o AS (
    SELECT  'times_paneu_output' AS name, pathway
    FROM    model_draft.reeem_times_paneu_input
    GROUP BY pathway)
CREATE OR REPLACE VIEW model_draft.reeem_pathways_view AS
    SELECT  name AS table_name,
            pathway
    FROM    times_i AS a;

ALTER TABLE model_draft.reeem_pathways_view OWNER TO reeem_user; 

-- access rights
ALTER TABLE             model_draft.reeem_pathways_view OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_pathways_view TO reeem_read WITH GRANT OPTION;

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.1.0','setup','model_draft','reeem_pathways_view','reeem_db_view_pathways.sql',' ');
