/*
PLEXOS Data Cleaning and TAGGING

PLEXOS Input
PLEXOS Output

https://github.com/ReeemProject/reeem_db/issues/14

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Alexis Michaltsis"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/14"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/data-cleaning/reeem_db_clean_plexos.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-----------
-- CLEANING
-----------

-- No usage for data cleaning yet.


----------
-- TAGGING
----------

-- INPUT|OUTPUT remove all tags
UPDATE model_draft.reeem_plexos_input
    SET tags = NULL;

UPDATE model_draft.reeem_plexos_output
    SET tags = NULL;

-- INPUT|OUTPUT set model tag
UPDATE model_draft.reeem_plexos_input
    SET tags = COALESCE(tags, '') || hstore('model', 'plexos');

UPDATE model_draft.reeem_plexos_output
    SET tags = COALESCE(tags, '') || hstore('model', 'plexos');

-- INPUT|OUTPUT set schema tag
UPDATE model_draft.reeem_plexos_input
    SET tags = COALESCE(tags, '') || hstore('schema', 'demand');

UPDATE model_draft.reeem_plexos_output
    SET tags = COALESCE(tags, '') || hstore('schema', 'supply');

-- INPUT set field tag
UPDATE model_draft.reeem_plexos_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'electricity')
    WHERE   field LIKE 'electricity';

UPDATE model_draft.reeem_plexos_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'resource')
    WHERE   field LIKE 'resource';

-- INPUT set category tag
UPDATE model_draft.reeem_plexos_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'demand')
    WHERE   field LIKE 'electricity' AND
            category LIKE 'demand%';

UPDATE model_draft.reeem_plexos_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'capacity;exchange')
    WHERE   field LIKE 'electricity' AND
            category LIKE '%Exchange%';

UPDATE model_draft.reeem_plexos_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'capacity;installed')
    WHERE   field LIKE 'electricity' AND
            category LIKE '%Installed%';

UPDATE model_draft.reeem_plexos_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'price')
    WHERE   field LIKE 'resource' AND
            category LIKE '%prices%';

-- OUTPUT set field tag
UPDATE model_draft.reeem_plexos_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'electricity')
    WHERE   field LIKE 'electricity';

UPDATE model_draft.reeem_plexos_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'electricity')
    WHERE   field LIKE 'emission';

UPDATE model_draft.reeem_plexos_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'resource')
    WHERE   field LIKE 'resource';

-- OUTPUT set category tag
UPDATE model_draft.reeem_plexos_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'load')
    WHERE   field LIKE 'electricity' AND
            category LIKE 'Load';

UPDATE model_draft.reeem_plexos_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'generation')
    WHERE   field LIKE 'electricity' AND
            category LIKE '%Generation%';

UPDATE model_draft.reeem_plexos_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'exchange;export')
    WHERE   field LIKE 'electricity' AND
            category LIKE '%Exchange - Export';

UPDATE model_draft.reeem_plexos_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'exchange;import')
    WHERE   field LIKE 'electricity' AND
            category LIKE '%Exchange - Import';

UPDATE model_draft.reeem_plexos_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'exchange;net')
    WHERE   field LIKE 'electricity' AND
            category LIKE '%Net interchange';

UPDATE model_draft.reeem_plexos_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'price')
    WHERE   field LIKE 'electricity' AND
            category LIKE 'Prices';

UPDATE model_draft.reeem_plexos_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'emission')
    WHERE   field LIKE 'emission' AND
            category LIKE 'Emissions';

UPDATE model_draft.reeem_plexos_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'consumption')
    WHERE   field LIKE 'resource' AND
            category LIKE '%Consumption%';


---------------------------------------
-- SELECT (execute as separate queries)
---------------------------------------

-- INPUT example selects
SELECT  field, category, indicator, tags
FROM    model_draft.reeem_plexos_input
WHERE   tags IS NOT NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;

SELECT  field, category, indicator, tags
FROM    model_draft.reeem_plexos_input
WHERE   tags IS NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;

-- OUTPUT example select
SELECT  field, category, indicator, tags
FROM    model_draft.reeem_plexos_output
WHERE   tags IS NOT NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;

SELECT  field, category, indicator, tags
FROM    model_draft.reeem_plexos_output
WHERE   tags IS NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;


----------
-- LOGGING
----------

-- INPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_plexos_input','reeem_db_clean_plexos.sql',' ');
-- OUTPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_plexos_output','reeem_db_clean_plexos.sql',' ');
