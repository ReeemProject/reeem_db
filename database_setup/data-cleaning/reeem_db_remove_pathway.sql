/*
Remove (delete) an entire pathway from the database

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


-- delete pathway from OSeMBE 2019-01-09 
DELETE FROM model_draft.reeem_osembe_output
    WHERE	pathway = 'C0T1E10';

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_osembe_output','reeem_db_remove_pathway.sql',' ');



-- delete pathway from TIMESPanEU 2019-01-11 
DELETE FROM model_draft.reeem_times_paneu_input
    WHERE	pathway = 'Base' AND framework = 'FrameworkV1' AND version = 'DataV4';

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_times_paneu_input','reeem_db_remove_pathway.sql',' ');


DELETE FROM model_draft.reeem_times_paneu_output
    WHERE	(pathway = 'Base' AND framework = 'FrameworkV1' AND version = 'DataV4') OR
            (pathway = 'Base' AND framework = 'FrameworkV2' AND version = 'DataV2') OR
            (pathway = 'HighRES' AND framework = 'FrameworkV1' AND version = 'DataV4');

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_times_paneu_output','reeem_db_remove_pathway.sql',' ');
