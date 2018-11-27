/*
REEEM-DB - View - Energy Demand - Example

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/reeem_db_setup_energypro.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- view
DROP VIEW IF EXISTS model_draft.reeem_db_energydemand_view;
CREATE VIEW         model_draft.reeem_db_energydemand_view AS
    SELECT  id,
            pathway,
            framework,
            version,
            region,
            year,
            category,
            indicator,
            value,
            unit,
            aggregation,
            tags,
            updated,
            md.mj AS metadata
    FROM    model_draft.reeem_times_paneu_input,
            (SELECT obj_description('model_draft.reeem_times_paneu_input' ::regclass) ::json AS mj) AS md
    WHERE   (pathway = 'Base' OR pathway = 'HighRES') AND
            version = 'DataV1' AND
            --region = 'SE' AND
            tags @> '"model"=>"times_paneu"'::hstore AND
            tags @> '"field"=>"service_demand"'::hstore AND
            tags @> '"demand_sector"=>"agriculture"'::hstore
    ORDER BY pathway, version, region, year;

ALTER TABLE model_draft.reeem_db_energydemand_view OWNER TO reeem_user; 

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.3.0','view','model_draft','reeem_db_energydemand_view','reeem_db_view_demand_example.sql',' ');


-- Difference calculation
    WITH v1 AS (SELECT "version","region","year","category","indicator","value","unit","updated"
        FROM    model_draft.reeem_db_energydemand_view
        WHERE   pathway = 'Base'), --AND year = '2010' AND "category" = 'Service demands agriculture'
        v2 AS (SELECT "version","region","year","category","indicator","value","unit","updated"
        FROM    model_draft.reeem_db_energydemand_view
        WHERE   pathway = 'HighRES')
    SELECT  v1."category",v1."year",v1."indicator",
            v1."region",-- AS region_1,v2."region" AS region_2,
            v1."value" AS value_1,v2."value"AS value_2,
            v1."unit",v1."updated"
    FROM    v1 INNER JOIN v2 ON (v1.region = v2.region AND v1.category = v2.category AND v1.indicator = v2.indicator)
    WHERE   v1.indicator = 'Agriculture' AND
            --v1.year = '2010' AND
            --v1.region = 'DE' AND
            v1."value" <> v2."value"
    ORDER BY region,year,"category";
    
    
   WITH v1 AS (SELECT "pathway","framework","version","region","year","category","indicator","value","unit","updated"
        FROM    model_draft.reeem_db_energydemand_view
        WHERE   pathway = 'Base' AND "framework" = 'FrameworkV1' AND version = 'DataV1'), --AND year = '2010' AND "category" = 'Service demands agriculture'
        v2 AS (SELECT "pathway","framework","version","region","year","category","indicator","value","unit","updated"
        FROM    model_draft.reeem_db_energydemand_view
        WHERE   pathway = 'HighRES' AND "framework" = 'FrameworkV1' AND version = 'DataV1')
    SELECT  v1."pathway",v1."framework",v1."version",
			v1."category",v1."year",v1."indicator",
            v1."region",-- AS region_1,v2."region" AS region_2,
            v1."value" AS value_1,v2."value" AS value_2, v1."value" - v2."value" AS diff,
            v1."unit",v1."updated"
    FROM    v1 INNER JOIN v2 ON (v1.region = v2.region AND v1.category = v2.category AND v1.indicator = v2.indicator)
    WHERE   v1.indicator = 'Agriculture' AND
			v1."framework" = 'FrameworkV1' AND v1.version = 'DataV1' AND
			v1.year = v2.year AND
            --v1.year = '2010' AND
            --v1.region = 'DE' AND
            v1."value" <> v2."value"
    ORDER BY region,year,"category";
    
    
   WITH v1 AS (SELECT "pathway","framework","version","region","year","category","indicator","value","unit","updated"
        FROM    model_draft.reeem_times_paneu_output
        WHERE   pathway = 'Base' AND "framework" = 'FrameworkV1' AND version = 'DataV3'
				AND tags @> '"field"=>"new_installed_capacity"'::hstore
				AND year = '2050' AND region = 'AT'
				AND category = 'NEW Capacities Public and Industrial Power Plants by Fuel and Technology_Solar_Photovoltaics'
				AND indicator = 'Photovoltaics'), --AND year = '2010' AND "category" = 'Service demands agriculture'
        v2 AS (SELECT "pathway","framework","version","region","year","category","indicator","value","unit","updated"
        FROM    model_draft.reeem_times_paneu_output
        WHERE   pathway = 'HighRES' AND "framework" = 'FrameworkV1' AND version = 'DataV3'
                AND tags @> '"field"=>"new_installed_capacity"'::hstore
				AND year = '2050' AND region = 'AT'
				AND category = 'NEW Capacities Public and Industrial Power Plants by Fuel and Technology_Solar_Photovoltaics'
				AND indicator = 'Photovoltaics')
    SELECT  v1."pathway",v1."framework",v1."version",
			v1."category",v1."year",v1."indicator",
            v1."region",-- AS region_1,v2."region" AS region_2,
            v1."value" AS value_1,v2."value" AS value_2, v1."value" - v2."value" AS diff,
            v1."unit",v1."updated"
    FROM    v1 INNER JOIN v2 ON (v1.region = v2.region AND v1.category = v2.category AND v1.indicator = v2.indicator)
    WHERE   v1."framework" = 'FrameworkV1' AND v1.version = 'DataV1' AND
			v1.year = v2.year AND
            v1."value" <> v2."value"
    ORDER BY region,year,"category";