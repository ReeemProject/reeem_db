
-- mview
DROP MATERIALIZED VIEW IF EXISTS model_draft.reeem_db_km_batteries_mview;
CREATE MATERIALIZED VIEW         model_draft.reeem_db_km_batteries_mview AS
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
    WHERE   category = 'Installed Capacities Public and Industrial Power Plants by Fuel and Technology_Electricity Storage' AND
            (indicator = 'Batteries' OR indicator = '   Batteries') AND
            ((framework = 'FrameworkV1' AND pathway = 'HighRES' AND version = 'DataV1') OR
            (framework = 'FrameworkV1' AND pathway = 'Base' AND version = 'DataV4')) AND 
            (year IN ('2020', '2030', '2040', '2050'))
    ORDER BY pathway, version, region, year;

ALTER TABLE model_draft.reeem_db_km_batteries_mview OWNER TO reeem_pathway; 

-- index (id)
CREATE UNIQUE INDEX reeem_db_km_batteries_mview_idx
    ON model_draft.reeem_db_km_batteries_mview (id);

UPDATE model_draft.reeem_times_paneu_output AS u 
    SET     tags = COALESCE(tags, '') || hstore('key_message', 'true')
    FROM    (
        SELECT a.id
        FROM model_draft.reeem_times_paneu_output a
        JOIN model_draft.reeem_db_km_batteries_mview b ON a.id = b.id
            ) AS s
	WHERE u.id = s.id;

REFRESH MATERIALIZED VIEW model_draft.reeem_db_km_batteries_mview;

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.3.0','view','model_draft','reeem_db_km_batteries_mview','reeem_db_view_keymessage_batteries.sql',' ');
SELECT scenario_log('REEEM','v0.3.0','view','model_draft','reeem_times_paneu_output','reeem_db_view_keymessage_batteries.sql',' ');


-- view for hasura
DROP VIEW IF EXISTS model_draft.reeem_db_km_batteries_view;
CREATE VIEW         model_draft.reeem_db_km_batteries_view AS
    SELECT  *
    FROM    model_draft.reeem_db_km_batteries_mview;
    
ALTER TABLE model_draft.reeem_db_km_batteries_view OWNER TO reeem_pathway; 


-- direct view
DROP VIEW IF EXISTS model_draft.reeem_db_km_batteries_dview;
CREATE VIEW         model_draft.reeem_db_km_batteries_dview AS
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
    WHERE   category = 'Installed Capacities Public and Industrial Power Plants by Fuel and Technology_Electricity Storage' AND
            (indicator = 'Batteries' OR indicator = '   Batteries') AND
            ((framework = 'FrameworkV1' AND pathway = 'HighRES' AND version = 'DataV1') OR
            (framework = 'FrameworkV1' AND pathway = 'Base' AND version = 'DataV4')) AND 
            (year IN ('2020', '2030', '2040', '2050'))
    ORDER BY pathway, version, region, year;

ALTER TABLE model_draft.reeem_db_km_batteries_dview OWNER TO reeem_pathway; 
