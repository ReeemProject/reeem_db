/*
TIMES PanEU Data Cleaning and Tagging

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


-----------
-- CLEANING
-----------

-- remove leading white space - regexp_replace(indicator, '^\s+', '')
UPDATE model_draft.reeem_times_paneu_input
    SET indicator = regexp_replace(indicator, '^\s+', '');

UPDATE model_draft.reeem_times_paneu_output
    SET indicator = regexp_replace(indicator, '^\s+', '');

UPDATE model_draft.reeem_times_paneu_output
    SET category = regexp_replace(category, '^\s+', '');


----------
-- TAGGING
----------

--------------------------
-- INPUT|OUTPUT remove all
--------------------------
UPDATE model_draft.reeem_times_paneu_input
    SET tags = NULL;

UPDATE model_draft.reeem_times_paneu_output
    SET tags = NULL;

-------------------------
-- INPUT|OUTPUT set model
-------------------------
UPDATE model_draft.reeem_times_paneu_input
    SET tags = COALESCE(tags, '') || hstore('model', 'times_paneu');

UPDATE model_draft.reeem_times_paneu_output
    SET tags = COALESCE(tags, '') || hstore('model', 'times_paneu');

-------------------
-- INPUT set schema
-------------------
UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('schema', 'economy')
    WHERE   category LIKE '%prices%' OR
            category LIKE 'Fix costs%' OR
            category LIKE 'Investment costs%' OR
            category LIKE 'Variable costs%';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('schema', 'demand')
    WHERE   category LIKE 'Service demands%';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('schema', 'supply')
    WHERE   category LIKE 'Efficiency%' OR
            category LIKE 'Electrical efficiency%' OR
            category LIKE 'Lifetime%' OR
            category LIKE '%electricity production%' OR
            category LIKE 'Potentials of biomass';

------------------
-- INPUT set field
------------------
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
    SET     tags = COALESCE(tags, '') || hstore('demand_sector', 'household')
    WHERE   category LIKE '%households';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('field', 'price')
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

---------------------
-- INPUT set category
---------------------
UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_heating_plant;biomass')
    WHERE   category LIKE '%public heating plants Biomass';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_heating_plant;coal')
    WHERE   category LIKE '%public heating plants Coal';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_heating_plant;electricity')
    WHERE   category LIKE '%public heating plants Electricity';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_heating_plant;gas')
    WHERE   category LIKE '%public heating plants Gas';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_heating_plant;oil')
    WHERE   category LIKE '%public heating plants Oil';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_heating_plant;solarthermal')
    WHERE   category LIKE '%public heating plants Solarthermal';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'storage')
    WHERE   category LIKE '%storage%';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_power_plant;combined_heat_and_power_plant')
    WHERE   category LIKE '%public power and CHP plants%';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_power_plant;combined_heat_and_power_plant;biomass')
    WHERE   category LIKE '%public power and CHP plants Biomass%';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_power_plant;combined_heat_and_power_plant;coal')
    WHERE   category LIKE '%public power and CHP plants Coal';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_power_plant;combined_heat_and_power_plant;gas')
    WHERE   category LIKE '%public power and CHP plants Gas%';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_power_plant;combined_heat_and_power_plant;geothermal')
    WHERE   category LIKE '%public power and CHP plants Geothermal';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_power_plant;combined_heat_and_power_plant;hydro')
    WHERE   category LIKE '%public power and CHP plants Hydro';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_power_plant;combined_heat_and_power_plant;lignite')
    WHERE   category LIKE '%public power and CHP plants Lignite';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_power_plant;combined_heat_and_power_plant;nuclear')
    WHERE   category LIKE '%public power and CHP plants Nuclear';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_power_plant;combined_heat_and_power_plant;oil')
    WHERE   category LIKE '%public power and CHP plants Oil';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_power_plant;combined_heat_and_power_plant;pv')
    WHERE   category LIKE '%public power and CHP plants PV';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_power_plant;combined_heat_and_power_plant;solarthermal')
    WHERE   category LIKE '%public power and CHP plants Solarthermal';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_power_plant;combined_heat_and_power_plant;waste')
    WHERE   category LIKE '%public power and CHP plants Waste';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'public_power_plant;combined_heat_and_power_plant;wind')
    WHERE   category LIKE '%public power and CHP plants Wind';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'fuel')
    WHERE   category LIKE 'Fuel prices';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'import_fuel')
    WHERE   category LIKE 'Import fuel prices';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'renewables')
    WHERE   category LIKE '%renewables';

UPDATE model_draft.reeem_times_paneu_input
    SET     tags = COALESCE(tags, '') || hstore('category', 'biomass')
    WHERE   category LIKE 'Potentials of biomass';

--------------------
-- OUTPUT set schema
--------------------
UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('schema', 'economy')
    WHERE   category LIKE 'Activity%' OR
            category LIKE 'Average electricity price' OR
            category LIKE 'CO2 prices' OR
            category LIKE 'Distric Heat price%' OR
            category LIKE 'Electricity Exchange%' OR
            category LIKE 'Electricity price%' OR
            category LIKE 'External Costs%' OR
            category LIKE 'Fixed O&M costs%' OR
            category LIKE 'Fuel prices%' OR
            category LIKE 'Investment costs%' OR
            category LIKE 'Variable O&M costs%' OR
            indicator LIKE 'Activity%' OR
            indicator LIKE 'CO2 prices%' OR
            indicator LIKE 'Discount rate' OR
            indicator LIKE 'District Heat price per timeslice' OR
            indicator LIKE 'Electricity price per timeslice' OR
            indicator LIKE 'Fixed O&M costs%' OR
            indicator LIKE 'Investment costs%' OR
            indicator LIKE 'Variable O&M costs%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('schema', 'demand')
    WHERE   category LIKE 'Final energy consumption%' OR
            category LIKE 'Net electricity consumption%' OR
            category LIKE 'Net import%' OR
            category LIKE 'Primary energy consumption%' OR
            indicator LIKE 'Final energy consumption Transport' OR
            indicator LIKE 'Electricity Exchange - Import' OR
            indicator LIKE 'Electricity Exchange - Net Imports%' OR
            indicator LIKE 'Final energy consumption%' OR
            indicator LIKE 'Net electricity consumption%' OR
            indicator LIKE 'Net import%' OR
            indicator LIKE 'Primary energy consumption%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('schema', 'supply')
    WHERE   category LIKE 'Biomass production' OR
            category LIKE 'Domestic production%' OR
            category LIKE 'Electricity Production%' OR
            category LIKE 'Fuel Input%' OR
            category LIKE 'Heat Production%' OR
            category LIKE 'Installed Capacities%' OR
            category LIKE 'NEW Capacities%' OR
            category LIKE 'Vehicle Stock%' OR
            indicator LIKE 'Biomass production' OR
            indicator LIKE 'Domestic production%' OR
            indicator LIKE 'Electricity Exchange - Capacities' OR
            indicator LIKE 'Electricity Exchange - Export' OR
            indicator LIKE 'Electricity Production%' OR
            indicator LIKE 'Fuel Input%' OR
            indicator LIKE 'Heat Production%' OR
            indicator LIKE 'Installed Capacities%' OR
            indicator LIKE 'NEW Capacities%' OR
            indicator LIKE 'Vehicle Stock%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('schema', 'environment')
    WHERE   category LIKE 'Emissions%' OR
            indicator LIKE 'Emissions%';

-------------------
-- OUTPUT set field
-------------------
UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'final_energy_consumption')
    WHERE   category LIKE 'Final energy consumption%' OR
            indicator LIKE 'Final energy consumption%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'net_electricity_consumption')
    WHERE   category LIKE 'Net electricity consumption%' OR
            indicator LIKE 'Net electricity consumption%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'primary_energy_consumption')
    WHERE   category LIKE 'Primary energy consumption%' OR
            indicator LIKE 'Primary energy consumption%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'net_import')
    WHERE   category LIKE 'Net import%' OR
            indicator LIKE 'Net import%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'domestic_production')
    WHERE   category LIKE 'Domestic production%' OR
            indicator LIKE 'Domestic production%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'installed_capacity')
    WHERE   category LIKE 'Installed Capacities%' OR
            indicator LIKE 'Installed Capacities%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'new_installed_capacity')
    WHERE   category LIKE 'NEW Capacities%' OR
            indicator LIKE 'NEW Capacities%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'electricity_production')
    WHERE   category LIKE 'Electricity Production%' OR
            indicator LIKE 'Electricity Production%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'heat_production')
    WHERE   category LIKE 'Heat Production%' OR
            indicator LIKE 'Heat Production%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'fuel_input')
    WHERE   LOWER(category) LIKE 'fuel input%' OR
            LOWER(indicator) LIKE 'fuel input%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'electricity_exchange')
    WHERE   category LIKE 'Electricity Exchange%' OR
            indicator LIKE 'Electricity Exchange%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'emissions')
    WHERE   category LIKE 'Emissions%' OR
            indicator LIKE 'Emissions%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'electricity_price')
    WHERE   LOWER(category) LIKE '%electricity price%' OR
            LOWER(indicator) LIKE '%electricity price%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'heat_price')
    WHERE   LOWER(category) LIKE '%heat price%' OR
            LOWER(indicator) LIKE '%heat price%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'co2_price')
    WHERE   category LIKE 'CO2%' OR
            indicator LIKE 'CO2%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'fuel_price')
    WHERE   LOWER(category) LIKE 'fuel prices%';


UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'biomass_production')
    WHERE   category LIKE 'Biomass production' OR
            indicator LIKE 'Biomass production';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'vehicle_stock')
    WHERE   category LIKE 'Vehicle Stock%' OR
            indicator LIKE 'Vehicle Stock%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'activity')
    WHERE   category LIKE 'Activity%' OR
            indicator LIKE 'Activity%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'costs')
    WHERE   category LIKE '%costs%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'external_costs')
    WHERE   category LIKE 'External Costs%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'fix_costs')
    WHERE   indicator LIKE 'Fixed O&M costs%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'var_costs')
    WHERE   indicator LIKE 'Variable O&M costs%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'discount_rate')
    WHERE   indicator LIKE 'Discount rate';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('field', 'inv_costs')
    WHERE   indicator LIKE 'Investment costs%';

----------------------
-- OUTPUT set category
----------------------
UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'bus')
    WHERE   category LIKE 'Activity Bus' OR
            category LIKE 'Fuel Input Bus%' OR
            category LIKE 'Vehicle Stock Bus';


UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'car')
    WHERE   category LIKE 'Activity Car' OR
            category LIKE 'Fuel Input Car%' OR
            category LIKE 'Fixed O&M costs car' OR
            category LIKE 'Investment costs car' OR
            category LIKE 'Variable O&M costs car%' OR
            category LIKE 'Vehicle Stock Car' OR
            indicator LIKE 'Investment costs car';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'motorcycle')
    WHERE   category LIKE 'Activity Motorcycles' OR
            category LIKE 'Fuel Input Motorcycles%' OR
            category LIKE 'Fuel Input Motorcycles%' OR
            category LIKE 'Vehicle Stock Motorcycles';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'rail')
    WHERE   category LIKE 'Activity rail' OR
            category LIKE 'Fuel Input rail%' OR
            indicator LIKE 'Fuel Input rail';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'navigation')
    WHERE   category LIKE 'Fuel Input navigation%' OR
            indicator LIKE 'Fuel Input navigation';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'truck')
    WHERE   category LIKE 'Fuel Input Truck%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'truck_heavy')
    WHERE   category LIKE 'Activity Truck Heavy' OR
            category LIKE 'Vehicle Stock Truck HDV' OR
            indicator LIKE '%Truck HDV';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'truck_light')
    WHERE   category LIKE 'Activity Truck Light' OR
            category LIKE 'Vehicle Stock Truck LDV' OR
            indicator LIKE '%Truck LDV';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'district')
    WHERE   category LIKE 'Distric Heat price%' OR
            indicator LIKE 'District Heat price per timeslice';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'capacity')
    WHERE   category LIKE 'Electricity Exchange - Capacities' OR
            indicator LIKE 'Electricity Exchange - Capacities';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'export')
    WHERE   indicator LIKE 'Electricity Exchange - Export';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'import')
    WHERE   indicator LIKE 'Electricity Exchange - Import';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'net_import')
    WHERE   category LIKE 'Electricity Exchange - Net Imports%' OR
            indicator LIKE 'Electricity Exchange - Net Imports%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'household')
    WHERE   category LIKE 'Electricity price per timeslice household' OR
            LOWER(category) LIKE 'final energy consumption household%' OR
            category LIKE 'Fixed O&M costs household%' OR
            category LIKE 'Investment costs household%' OR
            indicator LIKE 'Final energy consumption Households';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'industry')
    WHERE   category LIKE 'Electricity price per timeslice industry' OR
            LOWER(category) LIKE 'final energy consumption industry%' OR
            category LIKE 'Fixed O&M costs industry%' OR
            category LIKE 'Investment costs industry%' OR
            indicator LIKE 'Final energy consumption Industry';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'industry;subsector')
    WHERE   indicator LIKE '%industry by subsector';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'transport')
    WHERE   category LIKE 'Electricity price per timeslice transport' OR
            indicator LIKE 'Final energy consumption Transport';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'combined_heat_and_power_plant;industrial;public')
    WHERE   category LIKE '%Public and Industrial CHP Plants%' OR
            indicator LIKE '%Public and Industrial CHP Plants%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'power_plant;industrial;public')
    WHERE   category LIKE '%Public and Industrial Power Plants%' OR
            indicator LIKE '%Public and Industrial Power Plants%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('electricity_storage', 'battery')
    WHERE   category LIKE '%_Electricity Storage' AND
            indicator LIKE '%Batteries' OR indicator LIKE 'Batteries';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'emittant')
    WHERE   category LIKE 'External Costs by Emittant%' OR
            category LIKE 'Emissions by Emittant%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'agriculture')
    WHERE   category LIKE 'Final energy consumption Agriculture' OR
            indicator LIKE 'Final energy consumption Agriculture';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'energy_carrier')
    WHERE   category LIKE '%energy carrier%' OR
            indicator LIKE '%energy carrier%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'sector')
    WHERE   category LIKE '%consumption by sector%' OR
            indicator LIKE '%consumption by sector%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'commercial')
    WHERE   category LIKE 'Final energy consumption Commercial' OR
            indicator LIKE 'Final energy consumption Commercial';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'household;demand_type;fuel_type')
    WHERE   indicator LIKE '%household by demand type and fuel type';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'renewables')
    WHERE   category LIKE '%consumption of renewables%' OR
            indicator LIKE '%consumption of renewables%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'transport')
    WHERE   category LIKE 'Final energy consumption Transport';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'aviation')
    WHERE   category LIKE 'Fuel Input aviation%' OR
            indicator LIKE 'Fuel Input aviation%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'power_plant')
    WHERE   category LIKE 'Fuel prices free power plant';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'variable_costs;domestic_production')
    WHERE   category LIKE 'Variable O&M costs Domestic production' OR
            indicator LIKE 'Variable O&M costs Domestic production';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'variable_costs;household')
    WHERE   category LIKE 'Variable O&M costs household%' OR
            indicator LIKE 'Variable O&M costs household%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'variable_costs;industry')
    WHERE   category LIKE 'Variable O&M costs industry%';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'bus')
    WHERE   indicator LIKE '%Bus';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'car')
    WHERE   indicator LIKE '%Car' OR
            indicator LIKE 'Fixed O&M costs car';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'motorcycle')
    WHERE   indicator LIKE '%Motorcycles';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'rail')
    WHERE   indicator LIKE 'Activity rail';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'truck_heavy')
    WHERE   indicator LIKE 'Activity Truck Heavy';

UPDATE model_draft.reeem_times_paneu_output
    SET     tags = COALESCE(tags, '') || hstore('category', 'truck_light')
    WHERE   indicator LIKE 'Activity Truck Light';


---------------------------------------
-- SELECT (execute as separate queries)
---------------------------------------

------------------------
-- INPUT example selects
------------------------
SELECT  category, indicator, tags
FROM    model_draft.reeem_times_paneu_input
WHERE   tags IS NOT NULL
GROUP BY category, indicator, tags
ORDER BY category, indicator;

SELECT  category, indicator, tags
FROM    model_draft.reeem_times_paneu_input
WHERE   tags IS NULL
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

-------------------------
-- OUTPUT example selects
-------------------------
SELECT  category, indicator, tags
FROM    model_draft.reeem_times_paneu_output
WHERE   tags IS NOT NULL
GROUP BY category, indicator, tags
ORDER BY category, indicator;

SELECT  category, indicator, tags
FROM    model_draft.reeem_times_paneu_output
WHERE   tags IS NULL
GROUP BY category, indicator, tags
ORDER BY category, indicator;

SELECT  category, indicator, unit, tags
FROM    model_draft.reeem_times_paneu_output
WHERE   tags IS NOT NULL
GROUP BY category, indicator, unit, tags
ORDER BY category, indicator;

SELECT  category, unit, tags
FROM    model_draft.reeem_times_paneu_output
WHERE   tags IS NOT NULL
GROUP BY category, unit, tags
ORDER BY category;


-------
-- MISC
-------

-- template

--UPDATE model_draft.reeem_times_paneu_output
--    SET     tags = COALESCE(tags, '') || hstore('field', '')
--    WHERE   category LIKE '%';


----------
-- LOGGING
----------

-- INPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_times_paneu_input','reeem_db_clean_times_paneu.sql',' ');
-- OUTPUT scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.2.0','setup','model_draft','reeem_times_paneu_output','reeem_db_clean_times_paneu.sql',' ');
