/*
OSeMOSYS MESCA Data Cleaning and TAGGING

OSeMOSYS MESCA Input
OSeMOSYS MESCA Output

https://github.com/ReeemProject/reeem_db/issues/45

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Pierre-Francois Duc"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/45"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/data-cleaning/reeem_db_clean_osemosys_mesca.sql
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
UPDATE model_draft.reeem_osemosys_mesca_input
    SET tags = NULL;

UPDATE model_draft.reeem_osemosys_mesca_output
    SET tags = NULL;

-- INPUT|OUTPUT set model tag
UPDATE model_draft.reeem_osemosys_mesca_input
    SET tags = COALESCE(tags, '') || hstore('model', 'osemosys_mesca');

UPDATE model_draft.reeem_osemosys_mesca_output
    SET tags = COALESCE(tags, '') || hstore('model', 'osemosys_mesca');

-- INPUT|OUTPUT set schema tag
UPDATE model_draft.reeem_osemosys_mesca_input
    SET tags = COALESCE(tags, '') || hstore('schema', 'economy');

UPDATE model_draft.reeem_osemosys_mesca_input
    SET tags = COALESCE(tags, '') || hstore('schema', 'demand')
    WHERE field LIKE 'Final demand';

UPDATE model_draft.reeem_osemosys_mesca_output
    SET tags = COALESCE(tags, '') || hstore('schema', 'society');

-- INPUT set field tag
UPDATE model_draft.reeem_osemosys_mesca_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'cost')
    WHERE   field LIKE 'Costs';

UPDATE model_draft.reeem_osemosys_mesca_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'efficiency')
    WHERE   field LIKE 'Efficiency';

UPDATE model_draft.reeem_osemosys_mesca_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'demand_electricity')
    WHERE   category LIKE 'Final demand Electricity';

UPDATE model_draft.reeem_osemosys_mesca_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'demand_heat')
    WHERE   category LIKE 'Final demand Heat';

UPDATE model_draft.reeem_osemosys_mesca_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'lifetime')
    WHERE   field LIKE 'Lifetime';

-- INPUT set category tag
UPDATE model_draft.reeem_osemosys_mesca_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'heating_plant')
    WHERE   category LIKE '%heating plants%';

UPDATE model_draft.reeem_osemosys_mesca_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'power_plant')
    WHERE   category LIKE '%power plants%';

-- OUTPUT set field tag
UPDATE model_draft.reeem_osemosys_mesca_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'security')
    WHERE   field LIKE 'Energy Security Coefficient';

-- OUTPUT set category tag
UPDATE model_draft.reeem_osemosys_mesca_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'energy_security_coefficient')
    WHERE   field LIKE 'Energy Security Coefficient';


---------------------------------------
-- SELECT (execute as separate queries)
---------------------------------------

-- INPUT example selects
SELECT  field, category, indicator, tags
FROM    model_draft.reeem_osemosys_mesca_input
WHERE   tags IS NOT NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;

SELECT  field, category, indicator, tags
FROM    model_draft.reeem_osemosys_mesca_input
WHERE   tags IS NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;

-- OUTPUT example select
SELECT  field, category, indicator, tags
FROM    model_draft.reeem_osemosys_mesca_output
WHERE   tags IS NOT NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;

SELECT  field, category, indicator, tags
FROM    model_draft.reeem_osemosys_mesca_output
WHERE   tags IS NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;


----------
-- LOGGING
----------

-- INPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_osemosys_mesca_input','reeem_db_clean_osemosys_mesca.sql',' ');
-- OUTPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_osemosys_mesca_output','reeem_db_clean_osemosys_mesca.sql',' ');
