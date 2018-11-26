/*
EnergyPRO Data Cleaning

EnergyPRO Input
EnergyPRO Output

https://github.com/ReeemProject/reeem_db/issues/8

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Alexis Michaltsis"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/8"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/data-cleaning/reeem_db_clean_energypro.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- 1. TAGGING
-- INPUT|OUTPUT remove all tags
UPDATE model_draft.reeem_energypro_input
    SET tags = NULL;

UPDATE model_draft.reeem_energypro_output
    SET tags = NULL;

-- INPUT|OUTPUT set model tag
UPDATE model_draft.reeem_energypro_input
    SET tags = COALESCE(tags, '') || hstore('model', 'energypro');

UPDATE model_draft.reeem_energypro_output
    SET tags = COALESCE(tags, '') || hstore('model', 'energypro');

-- INPUT|OUTPUT set schema tag
UPDATE model_draft.reeem_energypro_input
    SET tags = COALESCE(tags, '') || hstore('schema', 'economy');

UPDATE model_draft.reeem_energypro_output
    SET tags = COALESCE(tags, '') || hstore('schema', 'economy');

-- INPUT set field tag
UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'prices')
    WHERE   field LIKE 'Carbon price' OR
            field LIKE 'Prices';

UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'demand')
    WHERE   field LIKE 'Demand';

UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'efficiency')
    WHERE   field LIKE 'Efficiency%';

UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'costs')
    WHERE   field LIKE '%cost%';

UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('costs', 'inv')
    WHERE   field LIKE 'Investment%';

UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('costs', 'var')
    WHERE   field LIKE 'Variable%';

UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'taxes')
    WHERE   field LIKE 'Taxes';

-- INPUT set category tag
UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'carbon')
    WHERE   category LIKE 'Carbon%';

UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'district_heat')
    WHERE   field LIKE 'District heat%';

UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'plants')
    WHERE   field LIKE '%plants';

UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('plants', 'php')
    WHERE   field LIKE '%public heating plants';

UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('plants', 'ph_chp')
    WHERE   field LIKE '%public power and CHP plants';

UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('plants', 'biomass')
    WHERE   field LIKE '%plants' AND
            category LIKE 'Biomass';

UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('plants', 'coal')
    WHERE   field LIKE '%plants' AND
            category LIKE 'Coal';

UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('plants', 'gas')
    WHERE   field LIKE '%plants' AND
            category LIKE 'Gas';

UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('plants', 'oil')
    WHERE   field LIKE '%plants' AND
            category LIKE 'Oil';

UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('plants', 'solarthermal')
    WHERE   field LIKE '%plants' AND
            category LIKE 'solarthermal';

UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('plants', 'waste')
    WHERE   field LIKE '%plants' AND
            category LIKE 'Waste';

UPDATE model_draft.reeem_energypro_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'fuel')
    WHERE   category LIKE 'Fuel prices%' OR
            category LIKE 'Fuel taxes%';

-- OUTPUT set field tag
UPDATE model_draft.reeem_energypro_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'fuel_consumption')
    WHERE   category LIKE 'Fuel%';

UPDATE model_draft.reeem_energypro_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'production_costs')
    WHERE   category LIKE 'Production%';

-- OUTPUT set category tag
UPDATE model_draft.reeem_energypro_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'biomass')
    WHERE   field LIKE 'Fuel%' AND
            category LIKE 'Biomass';

UPDATE model_draft.reeem_energypro_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'bio_oil')
    WHERE   field LIKE 'Fuel%' AND
            category LIKE 'Bio oil';

UPDATE model_draft.reeem_energypro_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'coal')
    WHERE   field LIKE 'Fuel%' AND
            category LIKE 'Coal';

UPDATE model_draft.reeem_energypro_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'electricity')
    WHERE   field LIKE 'Fuel%' AND
            category LIKE 'Electricity';

UPDATE model_draft.reeem_energypro_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'heavy_fuel_oil')
    WHERE   field LIKE 'Fuel%' AND
            category LIKE 'Heavy fuel oil';

UPDATE model_draft.reeem_energypro_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'light_fuel_oil')
    WHERE   field LIKE 'Fuel%' AND
            category LIKE 'Light fuel oil';

UPDATE model_draft.reeem_energypro_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'natural_gas')
    WHERE   field LIKE 'Fuel%' AND
            category LIKE 'Natural gas';

UPDATE model_draft.reeem_energypro_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'waste')
    WHERE   field LIKE 'Fuel%' AND
            category LIKE 'Waste';

UPDATE model_draft.reeem_energypro_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'wood_pellet')
    WHERE   field LIKE 'Fuel%' AND
            category LIKE 'Wood pellet';

UPDATE model_draft.reeem_energypro_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'heat_and_electricity')
    WHERE   category LIKE 'Heat and%';


-- 2. SELECT (execute as separate queries)
-- INPUT example selects
SELECT  field, category, indicator, tags
FROM    model_draft.reeem_energypro_input
WHERE   tags IS NOT NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;

SELECT  field, category, indicator, tags
FROM    model_draft.reeem_energypro_input
WHERE   tags IS NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;

-- OUTPUT example select
SELECT  field, category, indicator, tags
FROM    model_draft.reeem_energypro_output
WHERE   tags IS NOT NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;

SELECT  field, category, indicator, tags
FROM    model_draft.reeem_energypro_output
WHERE   tags IS NULL
GROUP BY field, category, indicator, tags
ORDER BY field, category, indicator;


-- 3. LOGGING
-- INPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_energypro_input','reeem_db_clean_energypro.sql',' ');
-- OUTPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_energypro_output','reeem_db_clean_energypro.sql',' ');
