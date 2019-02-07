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
-- no
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
-- no
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
-- n/a
---------
-- OUTPUT
---------
-- n/a


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
-- n/a
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
-- n/a
---------
-- OUTPUT
---------
-- n/a


------
-- LCA
------
--------
-- INPUT
--------
-- n/a
---------
-- OUTPUT
---------
-- n/a


-------
-- LeCA
-------
--------
-- INPUT
--------
-- no
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
-- n/a
---------
-- OUTPUT
---------
-- n/a


---------
-- NEWAGE
---------
--------
-- INPUT
--------
-- no
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
-- n/a
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
-- n/a
---------
-- OUTPUT
---------
-- n/a
