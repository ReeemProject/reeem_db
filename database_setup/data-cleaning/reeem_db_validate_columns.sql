/*
Validate given columns in INPUT and OUTPUT tables of REEEM models

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Alexis Michaltsis"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/4"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/data-cleaning/reeem_db_validate_columns.sql
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-----------
-- EcoSense
-----------
--------
-- INPUT
--------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_ecosense_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_ecosense_input')
SELECT *
FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_ecosense_input;

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_ecosense_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_ecosense_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_ecosense_input
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_ecosense_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_ecosense_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_ecosense_input
WHERE testee is NULL;

---------
-- OUTPUT
---------
-- Full compare
WITH spec AS (
  SELECT column_name AS mandatory
  FROM information_schema.columns
  WHERE table_schema = 'model_draft'
    AND table_name   = 'reeem_model_data_template'),
testee AS (
  SELECT column_name AS reeem_ecosense_output
  FROM information_schema.columns
  WHERE table_schema = 'model_draft'
    AND table_name   = 'reeem_ecosense_output')
SELECT *
FROM spec
  FULL JOIN testee ON spec.mandatory = testee.reeem_ecosense_output
  WHERE spec.mandatory <> 'source';

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_ecosense_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_ecosense_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_ecosense_output
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_ecosense_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_ecosense_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_ecosense_output
WHERE testee is NULL AND spec.mandatory <> 'source';


--------------
-- EcoSenseEVA
--------------
--------
-- INPUT
--------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_ecosenseeva_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_ecosenseeva_input')
SELECT *
FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_ecosenseeva_input;

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_ecosenseeva_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_ecosenseeva_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_ecosenseeva_input
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_ecosenseeva_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_ecosenseeva_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_ecosenseeva_input
WHERE testee is NULL;

---------
-- OUTPUT
---------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_ecosenseeva_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_ecosenseeva_output')
SELECT *
  FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_ecosenseeva_output
  WHERE spec.mandatory <> 'source';

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_ecosenseeva_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_ecosenseeva_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_ecosenseeva_output
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_ecosenseeva_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_ecosenseeva_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_ecosenseeva_output
WHERE testee is NULL AND spec.mandatory <> 'source';


-------
-- EMC2
-------
--------
-- INPUT
--------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_emc2_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_emc2_input')
SELECT *
FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_emc2_input;

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_emc2_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_emc2_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_emc2_input
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_emc2_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_emc2_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_emc2_input
WHERE testee is NULL;

---------
-- OUTPUT
---------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_emc2_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_emc2_output')
SELECT *
  FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_emc2_output
  WHERE spec.mandatory <> 'source';

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_emc2_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_emc2_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_emc2_output
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_emc2_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_emc2_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_emc2_output
WHERE testee is NULL AND spec.mandatory <> 'source';


-------------
-- EnergyPLAN
-------------
--------
-- INPUT
--------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_energyplan_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_energyplan_input')
SELECT *
FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_energyplan_input;

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_energyplan_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_energyplan_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_energyplan_input
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_energyplan_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_energyplan_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_energyplan_input
WHERE testee is NULL;

---------
-- OUTPUT
---------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_energyplan_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_energyplan_output')
SELECT *
  FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_energyplan_output
  WHERE spec.mandatory <> 'source';

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_energyplan_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_energyplan_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_energyplan_output
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_energyplan_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_energyplan_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_energyplan_output
WHERE testee is NULL AND spec.mandatory <> 'source';


------------
-- EnergyPRO
------------
--------
-- INPUT
--------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_energypro_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_energypro_input')
SELECT *
FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_energypro_input;

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_energypro_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_energypro_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_energypro_input
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_energypro_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_energypro_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_energypro_input
WHERE testee is NULL;

---------
-- OUTPUT
---------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_energypro_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_energypro_output')
SELECT *
  FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_energypro_output
  WHERE spec.mandatory <> 'source';

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_energypro_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_energypro_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_energypro_output
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_energypro_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_energypro_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_energypro_output
WHERE testee is NULL AND spec.mandatory <> 'source';


-------
-- ESME
-------
--------
-- INPUT
--------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_esme_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_esme_input')
SELECT *
FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_esme_input;

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_esme_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_esme_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_esme_input
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_esme_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_esme_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_esme_input
WHERE testee is NULL;

---------
-- OUTPUT
---------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_esme_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_esme_output')
SELECT *
  FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_esme_output
  WHERE spec.mandatory <> 'source';

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_esme_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_esme_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_esme_output
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_esme_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_esme_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_esme_output
WHERE testee is NULL AND spec.mandatory <> 'source';


------------
-- Hydrology
------------
--------
-- INPUT
--------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_hydrology_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_hydrology_input')
SELECT *
FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_hydrology_input;

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_hydrology_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_hydrology_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_hydrology_input
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_hydrology_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_hydrology_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_hydrology_input
WHERE testee is NULL;

---------
-- OUTPUT
---------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_hydrology_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_hydrology_output')
SELECT *
  FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_hydrology_output
  WHERE spec.mandatory <> 'source';

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_hydrology_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_hydrology_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_hydrology_output
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_hydrology_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_hydrology_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_hydrology_output
WHERE testee is NULL AND spec.mandatory <> 'source';


------
-- LCA
------
--------
-- INPUT
--------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_lca_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_lca_input')
SELECT *
FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_lca_input;

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_lca_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_lca_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_lca_input
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_lca_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_lca_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_lca_input
WHERE testee is NULL;

---------
-- OUTPUT
---------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_lca_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_lca_output')
SELECT *
  FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_lca_output
  WHERE spec.mandatory <> 'source';

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_lca_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_lca_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_lca_output
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_lca_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_lca_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_lca_output
WHERE testee is NULL AND spec.mandatory <> 'source';


-------
-- LeCA
-------
--------
-- INPUT
--------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_leca_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_leca_input')
SELECT *
FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_leca_input;

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_leca_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_leca_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_leca_input
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_leca_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_leca_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_leca_input
WHERE testee is NULL;

---------
-- OUTPUT
---------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_leca_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_leca_output')
SELECT *
  FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_leca_output
  WHERE spec.mandatory <> 'source';

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_leca_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_leca_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_leca_output
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_leca_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_leca_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_leca_output
WHERE testee is NULL AND spec.mandatory <> 'source';


----------
-- MESSAGE
----------
--------
-- INPUT
--------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_message_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_message_input')
SELECT *
FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_message_input;

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_message_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_message_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_message_input
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_message_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_message_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_message_input
WHERE testee is NULL;

---------
-- OUTPUT
---------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_message_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_message_output')
SELECT *
  FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_message_output
  WHERE spec.mandatory <> 'source';

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_message_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_message_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_message_output
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_message_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_message_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_message_output
WHERE testee is NULL AND spec.mandatory <> 'source';


---------
-- NEWAGE
---------
--------
-- INPUT
--------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_newage_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_newage_input')
SELECT *
FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_newage_input;

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_newage_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_newage_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_newage_input
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_newage_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_newage_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_newage_input
WHERE testee is NULL;

---------
-- OUTPUT
---------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_newage_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_newage_output')
SELECT *
FROM spec
  FULL JOIN testee ON spec.mandatory = testee.reeem_newage_output
  WHERE spec.mandatory <> 'source';

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_newage_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_newage_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_newage_output
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_newage_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_newage_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_newage_output
WHERE testee is NULL AND spec.mandatory <> 'source';


---------
-- OSeMBE
---------
--------
-- INPUT
--------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_osembe_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_osembe_input')
SELECT *
FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_osembe_input;

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_osembe_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_osembe_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_osembe_input
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_osembe_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_osembe_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_osembe_input
WHERE testee is NULL;

---------
-- OUTPUT
---------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_osembe_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_osembe_output')
SELECT *
FROM spec
  FULL JOIN testee ON spec.mandatory = testee.reeem_osembe_output
  WHERE spec.mandatory <> 'source';

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_osembe_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_osembe_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_osembe_output
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_osembe_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_osembe_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_osembe_output
WHERE testee is NULL AND spec.mandatory <> 'source';


-----------------
-- OSeMOSYS-MESCA
-----------------
--------
-- INPUT
--------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_osemosys_mesca_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_osemosys_mesca_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_osemosys_mesca_input;

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_osemosys_mesca_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_osemosys_mesca_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_osemosys_mesca_input
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_osemosys_mesca_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_osemosys_mesca_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_osemosys_mesca_input
WHERE testee is NULL;

---------
-- OUTPUT
---------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_osemosys_mesca_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_osemosys_mesca_output')
SELECT *
FROM spec
  FULL JOIN testee ON spec.mandatory = testee.reeem_osemosys_mesca_output
  WHERE spec.mandatory <> 'source';

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_osemosys_mesca_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_osemosys_mesca_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_osemosys_mesca_output
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_osemosys_mesca_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_osemosys_mesca_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_osemosys_mesca_output
WHERE testee is NULL AND spec.mandatory <> 'source';


---------
-- PLEXOS
---------
--------
-- INPUT
--------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_plexos_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_plexos_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_plexos_input;

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_plexos_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_plexos_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_plexos_input
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_plexos_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_plexos_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_plexos_input
WHERE testee is NULL;

---------
-- OUTPUT
---------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_plexos_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_plexos_output')
SELECT *
FROM spec
  FULL JOIN testee ON spec.mandatory = testee.reeem_plexos_output
  WHERE spec.mandatory <> 'source';

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_plexos_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_plexos_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_plexos_output
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_plexos_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_plexos_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_plexos_output
WHERE testee is NULL AND spec.mandatory <> 'source';


--------------
-- TIMES PanEU
--------------
--------
-- INPUT
--------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_times_paneu_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_times_paneu_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_times_paneu_input;

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_times_paneu_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_times_paneu_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_times_paneu_input
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_times_paneu_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_times_paneu_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_times_paneu_input
WHERE testee is NULL;

---------
-- OUTPUT
---------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_times_paneu_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_times_paneu_output')
SELECT *
FROM spec
  FULL JOIN testee ON spec.mandatory = testee.reeem_times_paneu_output
  WHERE spec.mandatory <> 'source';

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_times_paneu_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_times_paneu_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_times_paneu_output
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_times_paneu_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_times_paneu_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_times_paneu_output
WHERE testee is NULL AND spec.mandatory <> 'source';


----------------
-- UCL behaviour
----------------
--------
-- INPUT
--------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_ucl_behaviour_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_ucl_behaviour_input')
SELECT *
FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_ucl_behaviour_input;

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_ucl_behaviour_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_ucl_behaviour_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_ucl_behaviour_input
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_ucl_behaviour_input
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_ucl_behaviour_input')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_ucl_behaviour_input
WHERE testee is NULL;

---------
-- OUTPUT
---------
-- Full compare
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_ucl_behaviour_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_ucl_behaviour_output')
SELECT *
  FROM spec FULL JOIN testee ON spec.mandatory = testee.reeem_ucl_behaviour_output
  WHERE spec.mandatory <> 'source';

-- Extra
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_ucl_behaviour_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_ucl_behaviour_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_ucl_behaviour_output
WHERE spec is NULL;

-- Missing
WITH spec AS (
SELECT column_name AS mandatory
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_model_data_template'),
      testee AS (
SELECT column_name AS reeem_ucl_behaviour_output
FROM information_schema.columns
WHERE table_schema = 'model_draft'
  AND table_name   = 'reeem_ucl_behaviour_output')
SELECT *
FROM spec
FULL JOIN testee ON spec.mandatory = testee.reeem_ucl_behaviour_output
WHERE testee is NULL AND spec.mandatory <> 'source';
