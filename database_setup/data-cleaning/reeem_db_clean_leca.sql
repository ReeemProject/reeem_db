/*
LEcA Data Cleaning and TAGGING

-- TODO: LEcA Input
LEcA Output

https://github.com/ReeemProject/reeem_db/issues/9

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Pierre-Francois Duc"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/9"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/data-cleaning/reeem_db_clean_leca.sql
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

UPDATE model_draft.reeem_leca_output
    SET tags = NULL;

-- INPUT|OUTPUT set model tag
-- TODO: INPUT

UPDATE model_draft.reeem_leca_output
    SET tags = COALESCE(tags, '') || hstore('model', 'leca');

-- INPUT|OUTPUT set schema tag
-- TODO: INPUT

UPDATE model_draft.reeem_leca_output
    SET tags = COALESCE(tags, '') || hstore('schema', 'supply')
    WHERE indicator LIKE 'bioenergy supply' OR
          indicator LIKE 'Carbon Storage';

UPDATE model_draft.reeem_leca_output
    SET tags = COALESCE(tags, '') || hstore('schema', 'environment')
    WHERE indicator LIKE '%Area';

-- INPUT set field tag
-- TODO: INPUT

-- INPUT set category tag
-- TODO: INPUT

-- OUTPUT set field tag
UPDATE model_draft.reeem_leca_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'ecosysterm_services')
    WHERE   field LIKE 'ecosysterm services';

-- OUTPUT set category tag
UPDATE model_draft.reeem_leca_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'assessment')
    WHERE   category LIKE 'assessment';


---------------------------------------
-- SELECT (execute as separate queries)
---------------------------------------

-- INPUT example selects
-- TODO: INPUT
-- TODO: INPUT

-- OUTPUT example select
SELECT  field, category, indicator, tags
FROM    model_draft.reeem_leca_output
WHERE   tags IS NOT NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;

SELECT  field, category, indicator, tags
FROM    model_draft.reeem_leca_output
WHERE   tags IS NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;


----------
-- LOGGING
----------

-- INPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
-- TODO: INPUT SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_leca_input','reeem_db_clean_leca.sql',' ');
-- OUTPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_leca_output','reeem_db_clean_leca.sql',' ');
