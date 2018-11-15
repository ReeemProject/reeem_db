/*
TIMES PanEU Data Cleaning

TIMES PanEU Input
TIMES PanEU Output

https://github.com/ReeemProject/reeem_db/issues/4

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


-- remove leading white space - regexp_replace(indicator, '^\s+', '')
UPDATE model_draft.reeem_times_paneu_input
    SET indicator = regexp_replace(indicator, '^\s+', '');

UPDATE model_draft.reeem_times_paneu_output
    SET indicator = regexp_replace(indicator, '^\s+', '');

UPDATE model_draft.reeem_times_paneu_output
    SET category = regexp_replace(category, '^\s+', '');


-- remove all tags
UPDATE model_draft.reeem_times_paneu_input
    SET tags = NULL;

UPDATE model_draft.reeem_times_paneu_output
    SET tags = NULL;


-- set model tag
UPDATE model_draft.reeem_times_paneu_input
    SET tags = COALESCE(tags, '') || hstore('model', 'times_paneu');

UPDATE model_draft.reeem_times_paneu_output
    SET tags = COALESCE(tags, '') || hstore('model', 'times_paneu');



-- INPUT set field
UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'service_demand')
    WHERE   category LIKE 'Service demands%';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('demand_sector', 'residential')
    WHERE   category LIKE '%residential';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('demand_sector', 'commercial')
    WHERE   category LIKE '%commercial';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('demand_sector', 'agriculture')
    WHERE   category LIKE '%agriculture';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('demand_sector', 'transport')
    WHERE   category LIKE '%transport';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('demand_sector', 'industry')
    WHERE   category LIKE '%industry';


UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'fuel_price')
    WHERE   LOWER(category) LIKE '%fuel prices';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'potential')
    WHERE   category = 'Minimal electricity production of renewables' OR
            category = 'Maximum electricity production of renewables' OR
            category = 'Potentials of biomass';


UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'costs')
    WHERE   category LIKE '%costs%';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('costs', 'inv')
    WHERE   category LIKE 'Investment%';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('costs', 'fix')
    WHERE   category LIKE 'Fix%';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('costs', 'var')
    WHERE   category LIKE 'Variable%';


UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'lifetime')
    WHERE   category LIKE 'Lifetime%';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'efficiency')
    WHERE   LOWER(category) LIKE '%efficiency%';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'energy_carrier_price')
    WHERE   category LIKE 'Approximation energy carrier prices%';


-- OUTPUT set field
UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'final_energy_consumption')
    WHERE   category LIKE 'Final energy consumption%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'net_electricity_consumption')
    WHERE   category LIKE 'Net electricity consumption%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'primary_energy_consumption')
    WHERE   category LIKE 'Primary energy consumption%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'net_import')
    WHERE   category LIKE 'Net import%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'domestic_production')
    WHERE   category LIKE 'Domestic production%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'installed_capacity')
    WHERE   category LIKE 'Installed Capacities%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'new_installed_capacity')
    WHERE   category LIKE 'NEW Capacities%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'electricity_production')
    WHERE   category LIKE 'Electricity Production%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'heat_production')
    WHERE   category LIKE 'Heat Production%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'fuel_input')
    WHERE   LOWER(category) LIKE 'fuel input%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'electricity_exchange')
    WHERE   category LIKE 'Electricity Exchange%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'emissions')
    WHERE   category LIKE 'Emissions%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'electricity_price')
    WHERE   LOWER(category) LIKE '%electricity price%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'biomass_production')
    WHERE   category LIKE 'Biomass production';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'vehicle_stock')
    WHERE   category LIKE 'Vehicle Stock%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'activity')
    WHERE   category LIKE 'Activity%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'costs')
    WHERE   category LIKE '%costs%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'heat_price')
    WHERE   LOWER(category) LIKE '%heat price%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'co2_price')
    WHERE   category LIKE 'CO2%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'fuel_price')
    WHERE   LOWER(category) LIKE 'fuel prices%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'external_costs')
    WHERE   category LIKE 'External Costs%';


-- example selects
SELECT  category, indicator, tags
FROM    model_draft.reeem_times_paneu_output
WHERE   tags IS NOT NULL
GROUP BY category, indicator, tags
ORDER BY category, indicator;

-- example selects
SELECT  category, indicator, tags
FROM    model_draft.reeem_times_paneu_output
WHERE   tags IS NULL
GROUP BY category, indicator, tags
ORDER BY category, indicator;



-- template

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', '')
    WHERE   category LIKE '%';




-- example selects
SELECT  category, indicator, tags
FROM    model_draft.reeem_times_paneu_input
WHERE   tags IS NOT NULL
GROUP BY category, indicator, tags
ORDER BY category, indicator;


SELECT  category, LOWER(category), indicator, tags
FROM    model_draft.reeem_times_paneu_input
WHERE   LOWER(category) LIKE '%fuel prices'
GROUP BY category, indicator, tags
ORDER BY category, indicator;

SELECT  *
FROM    model_draft.reeem_times_paneu_input
WHERE   tags @> '"model"=>"times_paneu"'::hstore AND
        tags @> '"field"=>"service_demand"'::hstore;

SELECT  category, indicator, tags
FROM    model_draft.reeem_times_paneu_input
WHERE   category LIKE '%costs%'
GROUP BY category, indicator, tags
ORDER BY category, indicator;

-- select all data from model
SELECT  'In' AS data, *
FROM    model_draft.reeem_times_paneu_input
WHERE   tags @> '"model"=>"times_paneu"'::hstore
UNION ALL 
SELECT  'Out' AS data, *
FROM    model_draft.reeem_times_paneu_output
WHERE   tags @> '"model"=>"times_paneu"'::hstore
ORDER BY category, indicator;


-- set schema
UPDATE model_draft.reeem_times_paneu_input
    SET     tags = tags || hstore('schema', 'energy_demand')
    WHERE   category = 'Service demands residential' OR
    
    










-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.1.0','setup','model_draft','reeem_times_paneu_output','reeem_db_setup_times_paneu.sql',' ');
