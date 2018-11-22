/*
EcoSenseEVA Data Cleaning

--TODO EcoSenseEVA Input
EcoSenseEVA Output

https://github.com/ReeemProject/reeem_db/issues/7

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Alexis Michaltsis"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/7"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/data-cleaning/reeem_db_clean_ecosenseeva.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- 1. TAGGING
-- OUTPUT remove all tags
UPDATE model_draft.reeem_ecosenseeva_output
    SET tags = NULL;

-- OUTPUT set model tag
UPDATE model_draft.reeem_ecosenseeva_output
    SET tags = COALESCE(tags, '') || hstore('model', 'ecosenseeva');

-- OUTPUT set schema tag
UPDATE model_draft.reeem_ecosenseeva_output
    SET tags = COALESCE(tags, '') || hstore('schema', 'economy');

-- OUTPUT set field tag
UPDATE model_draft.reeem_ecosenseeva_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'health_externalities')
    WHERE   category LIKE 'health%';

-- OUTPUT set category tag
UPDATE model_draft.reeem_ecosenseeva_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'unit_costs')
    WHERE   category LIKE '%unit costs%';


-- 2. SELECT (execute as separate queries)
-- OUTPUT example selects
SELECT  category, indicator, tags
FROM    model_draft.reeem_ecosenseeva_output
WHERE   tags IS NOT NULL
GROUP BY category, indicator, tags
ORDER BY category, indicator;

SELECT  category, indicator, tags
FROM    model_draft.reeem_ecosenseeva_output
WHERE   tags IS NULL
GROUP BY category, indicator, tags
ORDER BY category, indicator;


-- 3. LOGGING
-- OUTPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_ecosenseeva_output','reeem_db_clean_ecosenseeva.sql',' ');
