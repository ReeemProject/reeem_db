/*
MESSAGE Data Cleaning and TAGGING

-- TODO: MESSAGE Input
MESSAGE Output

https://github.com/ReeemProject/reeem_db/issues/11

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Pierre-Francois Duc"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/11"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/data-cleaning/reeem_db_clean_message.sql
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

UPDATE model_draft.reeem_message_output
    SET tags = NULL;

-- INPUT|OUTPUT set model tag
-- TODO: INPUT

UPDATE model_draft.reeem_message_output
    SET tags = COALESCE(tags, '') || hstore('model', 'message');

-- INPUT|OUTPUT set schema tag
-- TODO: INPUT

UPDATE model_draft.reeem_message_output
    SET tags = COALESCE(tags, '') || hstore('schema', 'economy')
    WHERE category LIKE 'Electricity commercial flows%' OR
          category LIKE 'Electricity export%' OR
          category LIKE 'Electricity import%' OR
          category LIKE 'Fixed cost%' OR
          category LIKE 'Fuel cost%' OR
          category LIKE 'Investments%' OR
          category LIKE 'Variable cost%';

UPDATE model_draft.reeem_message_output
    SET tags = COALESCE(tags, '') || hstore('schema', 'supply')
    WHERE category LIKE 'Electricity supply%' OR
          category LIKE 'Heat production%' OR
          category LIKE 'New capacity%' OR
          category LIKE 'Primary reserve%' OR
          category LIKE 'Secondary reserve%' OR
          category LIKE 'Tertiary reserve%' OR
          category LIKE 'Total installed capacity%';

UPDATE model_draft.reeem_message_output
    SET tags = COALESCE(tags, '') || hstore('schema', 'demand')
    WHERE category LIKE 'Fuel consumption%' OR
          category LIKE 'Total primary energy requirement%';

UPDATE model_draft.reeem_message_output
    SET tags = COALESCE(tags, '') || hstore('schema', 'environment')
    WHERE category LIKE 'Emissions%';

-- INPUT set field tag
-- TODO: INPUT

-- INPUT set category tag
-- TODO: INPUT

-- OUTPUT set field tag
UPDATE model_draft.reeem_message_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'commercial_flows')
    WHERE   category LIKE '%commercial flows%';

UPDATE model_draft.reeem_message_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'export')
    WHERE   category LIKE '%export%';

UPDATE model_draft.reeem_message_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'import')
    WHERE   category LIKE '%import%';

UPDATE model_draft.reeem_message_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'electricity_supply')
    WHERE   category LIKE 'Electricity supply%';

UPDATE model_draft.reeem_message_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'emissions')
    WHERE   category LIKE 'Emissions%';

UPDATE model_draft.reeem_message_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'cost')
    WHERE   category LIKE '%cost%';

UPDATE model_draft.reeem_message_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'consumption')
    WHERE   category LIKE 'Fuel consumption%';

UPDATE model_draft.reeem_message_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'production')
    WHERE   category LIKE 'Heat production%';

UPDATE model_draft.reeem_message_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'investment')
    WHERE   category LIKE 'Investments%';

UPDATE model_draft.reeem_message_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'capacity')
    WHERE   category LIKE '%capacity%';

UPDATE model_draft.reeem_message_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'reserve')
    WHERE   category LIKE '%reserve%';

UPDATE model_draft.reeem_message_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'requirement')
    WHERE   category LIKE '%requirement%';

-- OUTPUT set category tag
UPDATE model_draft.reeem_message_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'xyz')
    WHERE   category LIKE 'xyz';


---------------------------------------
-- SELECT (execute as separate queries)
---------------------------------------

-- INPUT example selects
-- TODO: INPUT
-- TODO: INPUT

-- OUTPUT example select
SELECT  field, category, indicator, tags
FROM    model_draft.reeem_message_output
WHERE   tags IS NOT NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;

SELECT  field, category, indicator, tags
FROM    model_draft.reeem_message_output
WHERE   tags IS NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;


----------
-- LOGGING
----------

-- INPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
-- TODO: INPUT SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_message_input','reeem_db_clean_message.sql',' ');
-- OUTPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_message_output','reeem_db_clean_message.sql',' ');
