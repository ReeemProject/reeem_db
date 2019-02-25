
-- view
DROP MATERIALIZED VIEW IF EXISTS model_draft.reeem_db_wind_mview;
CREATE MATERIALIZED VIEW         model_draft.reeem_db_wind_mview AS
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
    FROM    model_draft.reeem_times_paneu_output,
            (SELECT obj_description('model_draft.reeem_times_paneu_input' ::regclass) ::json AS mj) AS md
    WHERE   (pathway = 'Base' OR pathway = 'HighRES') AND
            "framework" = 'FrameworkV1' AND version = 'DataV3' AND
            tags @> '"model"=>"times_paneu"'::hstore AND
            tags @> '"field"=>"new_installed_capacity"'::hstore AND
            category = 'NEW Capacities Public and Industrial Power Plants by Fuel and Technology_Wind' AND
			indicator = 'Onshore'
    ORDER BY pathway, version, region, year;

ALTER TABLE model_draft.reeem_db_wind_mview OWNER TO reeem_user; 

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.3.0','view','model_draft','reeem_db_wind_mview','reeem_db_view_wind_example.sql',' ');
