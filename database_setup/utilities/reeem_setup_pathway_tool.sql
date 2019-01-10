/*
REEEM Pathway Tool

https://github.com/ReeemProject/reeem_db/issues/43

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/utilities/reeem_setup_schema.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- REEEM pathway
DROP TABLE IF EXISTS    pathway.reeem_keymessage CASCADE;
CREATE TABLE            pathway.reeem_keymessage (
    "km_id"         serial NOT NULL,
    "topic"         text,
    "message"       text,
    "contact"       text,
    "schema"        text,
    "model"         text,
    "io"            text,
    "indicator"     text,
    "tag"           text,
    "updated"       timestamp with time zone,
    CONSTRAINT reeem_keymessage_pkey PRIMARY KEY (km_id) );

-- access rights
ALTER TABLE             pathway.reeem_keymessage OWNER TO reeem_pathway;
GRANT SELECT ON TABLE   pathway.reeem_keymessage TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE pathway.reeem_keymessage IS '{
    "title": "REEEM Key Messages",
    "description": "Main project results",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Europe",
        "resolution": "none"},
    "temporal": 
        {"reference_date": "none",
        "start": "none",
        "end": "none",
        "resolution": "none"},
    "sources": [
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""},
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""} ],
    "license":
        {"id": "CC-BY-4.0",
        "name": "Creative Commons Attribution 4.0 International",
        "version": "4.0",
        "url": "http://creativecommons.org/licenses/by/4.0/legalcode",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!",
        "copyright": "© REEEM Project"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2019-01-10", "comment": "Create table and metadata"} ],
    "resources": [
        {"name": "pathway.reeem_keymessage",
        "format": "PostgreSQL",
        "fields": [
            {"name": "km_id", "description": "Unique identifier", "unit": "none"},
            {"name": "topic", "description": "", "unit": "none"},
            {"name": "message", "description": "", "unit": "none"},
            {"name": "contact", "description": "", "unit": "none"},
            {"name": "schema", "description": "", "unit": "none"},
            {"name": "model", "description": "", "unit": "none"},
            {"name": "indicator", "description": "", "unit": "none"},
            {"name": "tag", "description": "", "unit": "none"},
            {"name": "id", "description": "", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.1','setup','pathway','reeem_keymessage','reeem_db_setup_pathway_tool.sql',' ');


-- REEEM pathway user comments
DROP TABLE IF EXISTS    pathway.reeem_usercomment CASCADE;
CREATE TABLE            pathway.reeem_usercomment (
    "uc_id"         serial NOT NULL,
    "km_id"         integer,
    "user_id"       integer,
    "comment"       text,
    "tag"           text,
    "updated"       timestamp with time zone,
    CONSTRAINT reeem_usercomment_pkey PRIMARY KEY (uc_id) );

-- access rights
ALTER TABLE             pathway.reeem_usercomment OWNER TO reeem_pathway;
GRANT SELECT ON TABLE   pathway.reeem_usercomment TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE pathway.reeem_usercomment IS '{
    "title": "REEEM User Comments",
    "description": "Comments from REEEM Pathways",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Europe",
        "resolution": "none"},
    "temporal": 
        {"reference_date": "none",
        "start": "none",
        "end": "none",
        "resolution": "none"},
    "sources": [
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""},
        {"name": "", "description": "", "url": "", "license": "", "copyright": ""} ],
    "license":
        {"id": "CC-BY-4.0",
        "name": "Creative Commons Attribution 4.0 International",
        "version": "4.0",
        "url": "http://creativecommons.org/licenses/by/4.0/legalcode",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!",
        "copyright": "© REEEM Project"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2019-01-10", "comment": "Create table and metadata"} ],
    "resources": [
        {"name": "pathway.reeem_usercomment",
        "format": "PostgreSQL",
        "fields": [
            {"name": "uc_id", "description": "Unique identifier", "unit": "none"},
            {"name": "km_id", "description": "FK on reeem_keymessage", "unit": "none"},
            {"name": "user_id", "description": "", "unit": "none"},
            {"name": "comment", "description": "", "unit": "none"},
            {"name": "tag", "description": "", "unit": "none"},
            {"name": "id", "description": "", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.1','setup','pathway','reeem_usercomment','reeem_db_setup_pathway_tool.sql',' ');
