/*
NEWAGE Data Cleaning and TAGGING

-- TODO: NEWAGE Input
NEWAGE Output

https://github.com/ReeemProject/reeem_db/issues/12

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Alexis Michaltsis"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/12"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/data-cleaning/reeem_db_clean_newage.sql
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

UPDATE model_draft.reeem_newage_output
    SET tags = NULL;

-- INPUT|OUTPUT set model tag
-- TODO: INPUT

UPDATE model_draft.reeem_newage_output
    SET tags = COALESCE(tags, '') || hstore('model', 'newage');

-- INPUT|OUTPUT set schema tag
-- TODO: INPUT

UPDATE model_draft.reeem_newage_output
    SET tags = COALESCE(tags, '') || hstore('schema', 'economy');

-- INPUT set field tag
-- TODO: INPUT

-- INPUT set category tag
-- TODO: INPUT

-- OUTPUT set field tag
UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'electricity')
    WHERE   category LIKE 'secondary energy,electricity';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'energy')
    WHERE   category LIKE 'emissions,co2,energy';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'gross_value_added;gva')
    WHERE   category LIKE 'GVA,unskilled labor,share';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'import')
    WHERE   category LIKE 'imports';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'gross_value_added;gva')
    WHERE   category LIKE 'gross value added';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'balance_of_trade;net_exports;nx')
    WHERE   category LIKE 'trade balance';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'employment')
    WHERE   category LIKE 'employment';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'revealed_comparative_advantage;rca')
    WHERE   category LIKE 'revealed comparative advantage';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'gross_domestic_product;gdp')
    WHERE   category LIKE 'economy' AND
            field LIKE 'gdp,mer';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'welfare')
    WHERE   category LIKE 'economy' AND
            field LIKE 'welfare';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'energy')
    WHERE   category LIKE 'final energy,electricty';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'price')
    WHERE   category LIKE 'price,carbon';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'gross_value_added;gva')
    WHERE   category LIKE 'GVA,skilled labor,share';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'export')
    WHERE   category LIKE 'exports';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'relative_world_trade_share')
    WHERE   category LIKE 'relative world trade share';

-- OUTPUT set category tag
UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'emission')
    WHERE   category LIKE 'emissions,co2,energy';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'labor;unskilled')
    WHERE   category LIKE 'GVA,unskilled labor,share';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'skilled')
    WHERE   category LIKE 'employment' AND
            field LIKE 'skilled';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'unskilled')
    WHERE   category LIKE 'employment' AND
            field LIKE 'unskilled';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'total')
    WHERE   category LIKE 'employment' AND
            field LIKE 'total';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'carbon')
    WHERE   category LIKE 'price,carbon';

UPDATE model_draft.reeem_newage_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'labor;skilled')
    WHERE   category LIKE 'GVA,skilled labor,share';


---------------------------------------
-- SELECT (execute as separate queries)
---------------------------------------

-- INPUT example selects
-- TODO: INPUT
-- TODO: INPUT

-- OUTPUT example select
SELECT  field, category, indicator, tags
FROM    model_draft.reeem_newage_output
WHERE   tags IS NOT NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;

SELECT  field, category, indicator, tags
FROM    model_draft.reeem_newage_output
WHERE   tags IS NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;


----------
-- LOGGING
----------

-- INPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
-- TODO: INPUT SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_newage_input','reeem_db_clean_newage.sql',' ');
-- OUTPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_newage_output','reeem_db_clean_newage.sql',' ');
