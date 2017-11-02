/*
database views

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
*/

-- version and regions
CREATE OR REPLACE VIEW model_draft.reeem_times_paneu_input_versions_view AS
    SELECT  'model_draft.reeem_times_paneu_input'::text AS table_name,
            a.version,
            count(a.region) AS regions
    FROM    (SELECT version,region
            FROM model_draft.reeem_times_paneu_input
            GROUP BY version,region) AS a
    GROUP BY version;

ALTER TABLE model_draft.reeem_times_paneu_input_versions_view OWNER TO reeem_user; 

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1','view','model_draft','reeem_times_paneu_input_versions_view','database_views.sql',' ');


-- select a value from different versions
CREATE OR REPLACE VIEW model_draft.reeem_times_paneu_input_versionsvalueexample_view AS
SELECT "version","region","field","category","indicator","year","value","unit","updated","source"
FROM    model_draft.reeem_times_paneu_input
WHERE   "indicator" = 'Agriculture'
        AND "year" = '2010'
        AND "region" = 'EU28';

ALTER TABLE model_draft.reeem_times_paneu_input_versionsvalueexample_view OWNER TO reeem_user; 

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1','view','model_draft','reeem_times_paneu_input_versionsvalueexample_view','database_views.sql',' ');


-- field view
CREATE OR REPLACE VIEW model_draft.reeem_times_paneu_input_fieldcnt_view AS
    SELECT  field,
            COUNT(field)
    FROM    model_draft.reeem_times_paneu_input
    GROUP BY field
    ORDER BY field;

ALTER TABLE model_draft.reeem_times_paneu_input_fieldcnt_view OWNER TO reeem_user; 

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1','view','model_draft','reeem_times_paneu_input_fieldcnt_view','database_views.sql',' ');


-- category view
CREATE OR REPLACE VIEW model_draft.reeem_times_paneu_input_categorycnt_view AS
    SELECT  field,
            category,
            COUNT(category)
    FROM    model_draft.reeem_times_paneu_input
    GROUP BY field, category
    ORDER BY field, category;

ALTER TABLE model_draft.reeem_times_paneu_input_categorycnt_view OWNER TO reeem_user; 

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1','view','model_draft','reeem_times_paneu_input_categorycnt_view','database_views.sql',' ');


-- reeem_times_paneu_input_test_view
CREATE OR REPLACE VIEW model_draft.reeem_times_paneu_input_regiontable_view AS
    SELECT  "id", "version", "region", "field", "category", "indicator", "year", "value", "unit", "source"
    FROM    model_draft.reeem_times_paneu_input
    WHERE   region = 'EU28' AND
            version = 'Test_data' AND
            "category" = 'Service demands residential' AND
            (year = 2010 OR year = 2015) AND
            aggregation IS FALSE AND
            "value" <> 0
    ORDER BY year,id ASC;

ALTER TABLE model_draft.reeem_times_paneu_input_regiontable_view OWNER TO reeem_user; 

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1','view','model_draft','reeem_times_paneu_input_regiontable_view','database_views.sql',' ');


-- see differences between two versions
CREATE OR REPLACE VIEW model_draft.reeem_times_paneu_input_dif_view AS
    WITH v1 AS (SELECT "version","region","dfid","field","category","indicator","year","value","unit","updated"
        FROM    model_draft.reeem_times_paneu_input
        WHERE   version = '0.1.1'), --AND year = '2010' AND "category" = 'Service demands agriculture'
        v2 AS (SELECT "version","region","dfid","field","category","indicator","year","value","unit","updated"
        FROM    model_draft.reeem_times_paneu_input
        WHERE   version = 'F1_TI1_P1')
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

ALTER TABLE model_draft.reeem_times_paneu_input_dif_view OWNER TO reeem_user; 

-- scenario log (version,io,schema_name,table_name,script_name,comment)
SELECT reeem_scenario_log('v0.1','view','model_draft','reeem_times_paneu_input_dif_view','database_views.sql',' ');
