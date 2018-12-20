/*
OSeMBE Data Cleaning and TAGGING

OSeMBE Input: Input data and model are combined an therefore not mappable to a database.
OSeMBE Output

https://github.com/ReeemProject/reeem_db/issues/13

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Alexis Michaltsis"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/13"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/data-cleaning/reeem_db_clean_osembe.sql
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-----------
-- CLEANING
-----------

-- remove leading white space - regexp_replace(indicator, '^\s+', '')
UPDATE model_draft.reeem_osembe_output
    SET field = regexp_replace(field, '^\s+', '');

UPDATE model_draft.reeem_osembe_output
    SET indicator = regexp_replace(indicator, '^\s+', '');


----------
-- TAGGING
----------

-------------------------------
-- OUTPUT remove all tags
-------------------------------
UPDATE model_draft.reeem_osembe_output
    SET tags = NULL;

-----------------------------
-- OUTPUT set model tag
-----------------------------
UPDATE model_draft.reeem_osembe_output
    SET tags = COALESCE(tags, '') || hstore('model', 'osembe');

------------------------------
-- OUTPUT set schema tag
------------------------------
UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('schema', 'economy')
    WHERE   field LIKE 'Activity%' OR
            field LIKE 'Average electricity price' OR
            field LIKE '%Vehicle%';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('schema', 'supply')
    WHERE   field LIKE 'Biomass production%' OR
            field LIKE 'Electricity Exchange%' OR
            field LIKE 'Electricity Production%' OR
            field LIKE 'Heat Production%' OR
            field LIKE 'Installed Capacities%' OR
            category LIKE 'Biomass production' OR
            category LIKE 'Electricity Exchange%' OR
            category LIKE 'Electricity Production%' OR
            category LIKE 'Installed Capacities%';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('schema', 'environment')
    WHERE   field LIKE 'Emissions%' OR
            category LIKE 'Emissions';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('schema', 'demand')
    WHERE   field LIKE 'Final energy consumption%' OR
            field LIKE 'Fuel Input%' OR
            field LIKE 'Primary energy consumption%' OR
            category LIKE 'Final energy consumption%' OR
            category LIKE 'Fuel Input%' OR
            category LIKE 'Primary energy consumption%';

-----------------------
-- OUTPUT set field tag
-----------------------
UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'activity')
    WHERE   field LIKE 'Activity%';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'avg_price')
    WHERE   field LIKE 'Average electricity price';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'biomass_production')
    WHERE   field LIKE 'Biomass production%' OR
            category LIKE 'Biomass production';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'electricity_exchange')
    WHERE   field LIKE 'Electricity Exchange%' OR
            category LIKE 'Electricity Exchange%';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'electricity_production')
    WHERE   field LIKE 'Electricity Production%' OR
            category LIKE 'Electricity Production%';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'emission')
    WHERE   field LIKE 'Emissions%' OR
            category LIKE 'Emissions';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'energy_consumption')
    WHERE   field LIKE 'Final energy consumption%' OR
            category LIKE 'Final energy consumption%';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'fuel_input')
    WHERE   field LIKE 'Fuel Input%' OR
            category LIKE 'Fuel Input%';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'heat_production')
    WHERE   field LIKE 'Heat Production%';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'installed_capacities')
    WHERE   field LIKE 'Installed Capacities%' OR
            category LIKE 'Installed Capacities%';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'primary_energy_consumption')
    WHERE   field LIKE 'Primary energy consumption%' OR
            category LIKE 'Primary energy consumption%';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'stock')
    WHERE   field LIKE '%Stock%';

--------------------------
-- OUTPUT set category tag
--------------------------
UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'rail')
    WHERE   field LIKE 'Activity rail%' OR
            field LIKE 'Fuel Input rail%' OR
            field LIKE 'Vehicle Stock rail%';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'road')
    WHERE   field LIKE 'Activity Road%' OR
            field LIKE 'Fuel Input Road%' OR
            field LIKE 'Road Vehicle%';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'capacities')
    WHERE   field LIKE 'Electricity Exchange - Capacities' OR
            category LIKE 'Electricity Exchange - Capacities';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'net_imports')
    WHERE   field LIKE 'Electricity Exchange - Net Imports%' OR
            category LIKE 'Electricity Exchange - Net Imports';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'power_plant;chp_plant;public;industrial')
    WHERE   field LIKE '%Public and Industrial Power and CHP Plants%' OR
            category LIKE '%Public and Industrial Power and CHP Plants%';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'chp_plant;public;industrial')
    WHERE   field LIKE '%Public and Industrial CHP Plants%';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'energy_carrier')
    WHERE   field LIKE 'Final energy consumption by energy carrier%' OR
            category LIKE 'Final energy consumption by energy carrier%';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'sector')
    WHERE   field LIKE 'Final energy consumption by sector';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'commercial')
    WHERE   field LIKE 'Final energy consumption Commercial';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'household')
    WHERE   field LIKE 'Final energy consumption Households';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'industry')
    WHERE   field LIKE 'Final energy consumption Industry';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'transport')
    WHERE   field LIKE 'Final energy consumption Transport';

UPDATE model_draft.reeem_osembe_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'renewables')
    WHERE   field LIKE 'Primary energy consumption of renewables' OR
            category LIKE 'Primary energy consumption of renewables';


--------------------------------------------------------------
-- SELECT: OUTPUT example select (execute as separate queries)
--------------------------------------------------------------

SELECT  field, category, indicator, tags
FROM    model_draft.reeem_osembe_output
WHERE   tags IS NOT NULL
GROUP BY field, category, indicator, tags
ORDER BY field, indicator;

SELECT  field, category, indicator, tags
FROM    model_draft.reeem_osembe_output
WHERE   tags IS NULL
GROUP BY field, category, indicator, tags
ORDER BY field, indicator;

SELECT  category, tags
FROM    model_draft.reeem_osembe_output
WHERE   tags IS NOT NULL
GROUP BY category, tags
ORDER BY category;

SELECT  category, tags
FROM    model_draft.reeem_osembe_output
WHERE   tags IS NULL
GROUP BY category, tags
ORDER BY category;


----------
-- LOGGING
----------

-- OUTPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_osembe_output','reeem_db_clean_osembe.sql',' ');
