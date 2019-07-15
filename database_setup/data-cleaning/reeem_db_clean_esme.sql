/*
ESME Data Cleaning and TAGGING

-- TODO: ESME Input
ESME Output

https://github.com/ReeemProject/reeem_db/issues/40

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Pierre-Francois Duc"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/40"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/data-cleaning/reeem_db_clean_esme.sql
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
-- TODO: INPUT

UPDATE model_draft.reeem_esme_output
    SET tags = NULL;

-- INPUT|OUTPUT set model tag
-- TODO: INPUT

UPDATE model_draft.reeem_esme_output
    SET tags = COALESCE(tags, '') || hstore('model', 'esme');

-- INPUT|OUTPUT set schema tag
-- TODO: INPUT

UPDATE model_draft.reeem_esme_output
    SET tags = COALESCE(tags, '') || hstore('schema', 'economy')
    WHERE category LIKE 'Cost metrics';

UPDATE model_draft.reeem_esme_output
    SET tags = COALESCE(tags, '') || hstore('schema', 'environment')
    WHERE category LIKE 'Captured CO2%' OR
          category LIKE 'Emissions';

UPDATE model_draft.reeem_esme_output
    SET tags = COALESCE(tags, '') || hstore('schema', 'supply')
    WHERE category LIKE '%supply' OR
          category LIKE '%production%' OR
          category LIKE '%Generation%' OR
          category LIKE '%generation%';

UPDATE model_draft.reeem_esme_output
    SET tags = COALESCE(tags, '') || hstore('schema', 'demand')
    WHERE category LIKE '%consumption' OR
          category LIKE '%use%';

-- INPUT set field tag
-- TODO: INPUT

-- INPUT set category tag
-- TODO: INPUT

-- OUTPUT set field tag
UPDATE model_draft.reeem_esme_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'cost')
    WHERE   category LIKE 'Cost metrics';

UPDATE model_draft.reeem_esme_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'storage')
    WHERE   category LIKE 'Captured CO2%';

UPDATE model_draft.reeem_esme_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'hydrogen_production')
    WHERE   category LIKE 'Hydrogen production%';

UPDATE model_draft.reeem_esme_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'power_generation')
    WHERE   category LIKE 'Power Generation%' OR
            category LIKE 'Power generation%';

UPDATE model_draft.reeem_esme_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'system')
    WHERE   category LIKE 'System%';

UPDATE model_draft.reeem_esme_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'transport')
    WHERE   category LIKE 'Transport%' OR
            category LIKE 'Biofuel%';

UPDATE model_draft.reeem_esme_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'industrial')
    WHERE   category LIKE 'Industrial%';

UPDATE model_draft.reeem_esme_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'pollution')
    WHERE   category LIKE 'Emissions';

UPDATE model_draft.reeem_esme_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'housing')
    WHERE   category LIKE 'Building energy consumption';

-- OUTPUT set category tag
UPDATE model_draft.reeem_esme_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'metric')
    WHERE   category LIKE 'Cost metrics';

UPDATE model_draft.reeem_esme_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'captured_co2')
    WHERE   category LIKE 'Captured CO2%';

UPDATE model_draft.reeem_esme_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'energy_consumption')
    WHERE   category LIKE '%energy consumption' OR
            category LIKE 'System wide energy use';

UPDATE model_draft.reeem_esme_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'fuel_consumption')
    WHERE   category LIKE '%fuel use';

UPDATE model_draft.reeem_esme_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'emission')
    WHERE   category LIKE 'Emissions';

UPDATE model_draft.reeem_esme_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'fuel')
    WHERE   category LIKE 'Biofuel%';


---------------------------------------
-- SELECT (execute as separate queries)
---------------------------------------

-- INPUT example selects
-- TODO: INPUT
-- TODO: INPUT

-- OUTPUT example select
SELECT  field, category, indicator, tags
FROM    model_draft.reeem_esme_output
WHERE   tags IS NOT NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;

SELECT  field, category, indicator, tags
FROM    model_draft.reeem_esme_output
WHERE   tags IS NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;


----------
-- LOGGING
----------

-- INPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
-- TODO: INPUT SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_esme_input','reeem_db_clean_esme.sql',' ');
-- OUTPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_esme_output','reeem_db_clean_esme.sql',' ');
