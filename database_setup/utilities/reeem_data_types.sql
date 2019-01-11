/*
Data types test

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__contains__    = "https://www.postgresql.org/docs/8.2/static/datatype-datetime.html"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/blob/master/database_setup/utilities/reeem_example_table.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- table with different timestamp formats and functions
DROP TABLE IF EXISTS 	model_draft.timestamp_test;
CREATE TABLE 		    model_draft.timestamp_test (
    id     		integer PRIMARY KEY,
    year 		smallint,
	month		integer,
    value 		double precision,
    year_month	text,
    timestamp1 	timestamp without time zone,
    timestamp2 	timestamp with time zone,
    timestamp3 	timestamp,
    timestamp4 	time without time zone,
    timestamp5 	time with time zone,
    comment 	text );

-- insert example data
INSERT INTO model_draft.timestamp_test VALUES (
    1,
    extract(year from now()),
    extract(month from now()),
	42.0,
    '2018-10',
    now(),
    now(),
    now(),
    now(),
    now(),
    'now');
	
	SELECT date_trunc('month', now())
	,to_char(now(),'YYYY-MM') 