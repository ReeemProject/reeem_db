/*
OSeMBE Table Setup

OSeMBE Input
OSeMBE Output

https://github.com/ReeemProject/reeem_db/issues/13

__copyright__   = "© Reiner Lemoine Institut"
__license__     = "GNU Affero General Public License Version 3 (AGPL-3.0)"
__url__         = "https://www.gnu.org/licenses/agpl-3.0.en.html"
__author__      = "Ludwig Hülk"
__issue__       = "https://github.com/ReeemProject/reeem_db/issues/13"

 * This file is part of project REEEM (https://github.com/ReeemProject/reeem_db).
 * It's copyrighted by the contributors recorded in the version control history:
 * ReeemProject/reeem_db/database_setup/reeem_db_setup_osembe.sql
 * 
 * SPDX-License-Identifier: AGPL-3.0-or-later
*/


-- OSeMBE Input
DROP TABLE IF EXISTS    model_draft.reeem_osembe_input CASCADE;
CREATE TABLE            model_draft.reeem_osembe_input (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "schema"        text,
    "category"      text,
    "tags"          hstore,
    "field"         text,
    "region"        text,
    "year"          smallint,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "updated"       timestamp with time zone,
    "source"        text,
    CONSTRAINT reeem_osembe_input_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_osembe_input OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_osembe_input TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_osembe_input IS '{
    "title": "REEEM OSeMBE Input",
    "description": "Input parameters: Service Demands, Fuel Prices, Potentials",
    "language": [ "eng" ],
    "spatial":
        {"location": "none",
        "extent": "Europe",
        "resolution": "Country"},
    "temporal":
        {"reference_date": "2015",
        "start": "2015",
        "end": "2060",
        "resolution": "15 timeslices per year"},
    "sources": [
        {
          "name": "Energy Technology Reference Indicator (ETRI) projections for 2010-2050",
          "description": "The Strategic Energy Technology Plan (SET-Plan) is the technology pillar of the EU''s energy and climate policy. This report contains assessments of energy technology reference indicators (ETRI) and it is aimed at providing independent and up-to-date cost and performance characteristics of the present and future European energy technology portfolio.",
          "url": "https://publications.europa.eu/en/publication-detail/-/publication/79a2ddbd-5ba1-4380-93af-2ce274a840f0/language-en",
          "license": "none",
          "copyright": "European Union"
        },
        {
          "name": "Catalog of CHP Technologies",
          "description": "The five technologies described in the Guide make up 97 percent of the CHP projects in place today and 99 percent of the total installed CHP electric capacity.",
          "url": "https://www.energy.gov/sites/prod/files/2016/09/f33/catalog_of_chp_technologies.pdf",
          "license": "none",
          "copyright": "none"
        },
        {
          "name": "WEIO 2014 PG Assumptions",
          "description": "Power Generation in the New Policies and 450 Scenarios, Assumed investment costs, operation and maintenance costs and efficiencies in the IEA World Energy Investment Outlook 2014",
          "url": "no longer available",
          "license": "none",
          "copyright": "OECD/IEA"
        },
        {
          "name": "EU Reference Scenario 2016",
          "description": "This report is an update of the previous Reference Scenario published in 2013. It focuses on the EU energy system, transport and greenhouse gas (GHG) emission developments, including specific sections on emission trends not related to energy, and on the various interactions among policies in these sectors.",
          "url": "https://publications.europa.eu/en/publication-detail/-/publication/aed45f8e-63e3-47fb-9440-a0a14370f243/language-en",
          "license": "none",
          "copyright": "European Union"
        },
        {
          "name": "IEA ETSAP - Technology Brief E03",
          "description": "Technology brief on Nuclear power",
          "url": "http://109.73.233.125/~ieaetsap/E-TechDS/PDF/E03-Nuclear-Power-GS-AD-gct.pdf",
          "license": "none",
          "copyright": "IEA ETSAP"
        },
        {
          "name": "Renewable Energy prospects: Germany, REmap 2030 analysis",
          "description": "IRENA REmap report identifying the gap between national renewable targets and the national renewable potential.",
          "url": "http://www.irena.org/publications/2015/Nov/Renewable-Energy-Prospects-Germany",
          "license": "none",
          "copyright": "IRENA"
        },
        {
          "name": "REmap 2030 Renewable Energy Prospects for Poland",
          "description": "IRENA REmap report identifying the gap between national renewable targets and the national renewable potential.",
          "url": "http://www.irena.org/publications/2015/Oct/REmap-2030-Renewable-Energy-Prospects-for-Poland",
          "license": "none",
          "copyright": "IRENA"
        },
        {
          "name": "Platts World Electric Power Plants Database",
          "description": "Data base of power plants with unit aggregation.",
          "url": "https://www.platts.com/products/world-electric-power-plants-database",
          "license": "none",
          "copyright": "S&P Global Platts"
        },
        {
          "name": "Wind in power",
          "description": "Annual report by the European Wind Energy Association, now WindEurope, on wind power statistics and installed wind power capacities.",
          "url": "https://windeurope.org/about-wind/statistics/european/wind-in-power-2015/",
          "license": "none",
          "copyright": "WindEurope asbl/vzw"
        },
        {
          "name": "Renewable Energy Statistics 2017",
          "description": "Statistics on renewable production, capacities and related financial flows.",
          "url": "http://www.irena.org/DocumentDownloads/Publications/IRENA_Renewable_Energy_Statistics_2017.pdf",
          "license": "none",
          "copyright": "IRENA"
        },
        {
          "name": "Renewable Power Generation Costs in 2014",
          "description": "Report on the the cost of renewable power generation, used for deriving biomass costs",
          "url": "http://www.irena.org/publications/2015/Jan/Renewable-Power-Generation-Costs-in-2014",
          "license": "none",
          "copyright": "IRENA"
        },
        {
          "name": "Production of Liquid Biofuels",
          "description": "Technology brief on the production of biofuels and its costs.",
          "url": "https://iea-etsap.org/E-TechDS/PDF/P10IR_Liq%20Biof_GS_Jan2013_final_GSOK.pdf",
          "license": "none",
          "copyright": "IEA-ETSAP and IRENA"
        },
        {
          "name": "DECC 2015 Fossil Fuel Price Assumptions",
          "description": "The report updates DECC’s long-term price projections for oil, gas and coal.",
          "url": "https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/477958/2015_DECC_fossil_fuel_price_assumptions.pdf",
          "license": "Open Government License",
          "copyright": "Crown copyright"
        },
        {
          "name": "The Economics of Nuclear Power",
          "description": "Webpage providing information on the operating cost of nuclear PP including the fuel cost.",
          "url": "http://www.world-nuclear.org/information-library/economic-aspects/economics-of-nuclear-power.aspx",
          "license": "none",
          "copyright": "World Nuclear Association"
        },
        {
          "name": "ENTSO-E Transparency Platform",
          "description": "Central collection and publication of electricity generation, transportation and consumption data and information for the pan-European market.",
          "url": "https://transparency.entsoe.eu/dashboard/show",
          "license": "none",
          "copyright": "none"
        },
        {
          "name": "Renewables-ninja",
          "description": "Renewables.ninja allows you to run simulations of the hourly power output from wind and solar power plants located anywhere in the world.",
          "url": "www.renewables.ninja",
          "license": "CC BY-NC 4.0",
          "copyright": "none"
        },
        {
          "name": "EU Emissions Trading System (ETS) data viewer",
          "description": "The EU ETS data viewer provides an easy access to emission trading data contained in the European Union Transaction Log (EUTL).",
          "url": "https://www.eea.europa.eu/data-and-maps/dashboards/emissions-trading-viewer-1",
          "license": "CC BY 2.5 DK",
          "copyright": "none"
        },
        {
          "name": "Total gross electricity generation",
          "description": "Data on the total gross electricity generation in the EU.",
          "url": "http://ec.europa.eu/eurostat/tgm/table.do?tab=table&init=1&plugin=1&language=en&pcode=ten00087",
          "license": "none",
          "copyright": "European Union"
        },
        {
          "name": "CO2 emission intensity",
          "description": "CO2 emission intensity of electricity in the EU by year.",
          "url": "https://www.eea.europa.eu/data-and-maps/daviz/co2-emission-intensity-3",
          "license": "CC BY 2.5 DK",
          "copyright": "European Environment Agency (EEA)"
        },
        {
          "name": "Forecast of energy demand in Norway towards 2050",
          "description": "The projection of energy demand is based on current policies, and is made for all energy carriers, and includes both stationary energy demand and transport for the analysis period 2010-2050.",
          "url": "https://www.ntnu.edu/documents/1261967833/1262617931/Energy+demand+in+Norway+towards+2050.pdf/80f05210-7380-4c19-b9ed-52801b9d3fe1",
          "license": "none",
          "copyright": "none"
        },
        {
          "name": "CenSES Energy demand projections towards 2050 - Reference path",
          "description": "A Position Paper prepared by FME CenSES",
          "url": "https://www.ntnu.edu/documents/1261967833/1262617931/Position-paper_Energy-Projections_utenbleed.pdf/0949b222-5d1b-4b06-9217-9287cb578b6a",
          "license": "none",
          "copyright": "none"
        },
        {
          "name": "Electricity statistics",
          "description": "The electricity statistics evaluate the production of electricity and the consumption of electrical energy in Switzerland.",
          "url": "http://www.bfe.admin.ch/themen/00526/00541/00542/00630/index.html?lang=en&dossier_id=04840",
          "license": "none",
          "copyright": "Swiss federal authorities"
        },
        {
          "name": "Geothermal energy Switzerland",
          "description": "Collection of information geothermal energy in general and in specific for Switzerland.",
          "url": "http://www.bfe.admin.ch/themen/00490/00501/index.html?lang=en",
          "license": "none",
          "copyright": "Swiss federal authorities"
        },
        {
          "name": "Potenzial - Geothermie Schweiz",
          "description": "Estimation of the potential of geothermal-energy in Switzerland useable for electricity production",
          "url": "https://geothermie-schweiz.ch/waermestrom/petrothermal/potenzial/",
          "license": "none",
          "copyright": "Geothermie-Schweiz.ch"
        },
        {
          "name": "Wasserkraftpotenzial der Schweiz",
          "description": "Report on current situation and potential of hydro power in Switzerland",
          "url": "https://www.swv.ch/wp-content/uploads/2018/03/Faktenblatt-Wasserkraftpotenzial_SWV.pdf",
          "license": "none",
          "copyright": "Schweizerischer Wasserwirtschaftsverband"
        },
        {
          "name": "OECD iLibrary - Waste",
          "description": "This database provides the latest and most comprehensive statistics across OECD countries on waste.",
          "url": "https://www.oecd-ilibrary.org/environment/data/oecd-environment-statistics/municipal-waste_data-00601-en",
          "license": "none",
          "copyright": "OECD"
        },
        {
          "name": "Facts 2015 Energy and water resources in Norway",
          "description": "Report on energy and water resources in Norway",
          "url": "https://www.regjeringen.no/en/aktuelt/fakta-2015-energi--og-vannressurser-i-norge/id2395568/",
          "license": "none",
          "copyright": "none"
        },
        {
          "name": "Wind Energy in Estonia",
          "description": "Status of Wind power in Estonia reported on the webpage of the Estonian Wind power Association",
          "url": "http://www.tuuleenergia.ee/en/windpower-101/statistics-of-estonia/",
          "license": "none",
          "copyright": "none"
        },
        {
          "name": "Wind energy statistics in Finland",
          "description": "Report on installed wind power capacities and power generation by wind power.",
          "url": "https://www.vttresearch.com/services/low-carbon-energy/wind-energy/wind-energy-statistics-in-finland",
          "license": "none",
          "copyright": "VTT"
        },
        {
          "name": "Wind energy assessment considering geographic and environmental restrictions in Sweden: A GIS-based approach",
          "description": "Journal paper on wind power potential in Sweden.",
          "url": "https://www.sciencedirect.com/science/article/pii/S0360544215001991?via%3Dihub",
          "license": "none",
          "copyright": "Elsevier Ltd."
        },
        {
          "name": "Gesetz über die friedliche Verwendung der Kernenergie und den Schutz gegen ihre Gefahren (Atomgesetz)",
          "description": "Atomgesetz in der Fassung der Bekanntmachung vom 15. Juli 1985 (BGBI. I S. 1565), das zuletzt durch Artikel 1 des Gesetzes vom 10. Juli 2018 (BGBI. I S. 1122) geändert worden ist",
          "url": "https://www.gesetze-im-internet.de/atg/AtG.pdf",
          "license": "none",
          "copyright": "none"
        },
        {
          "name": "Potenziale, Kosten und Umweltauswirkungen von Stromproduktionsanlagen - Synthese",
          "description": "Report on the potentials of different power generation technologies in Switzerland.",
          "url": "https://www.newsd.admin.ch/newsd/message/attachments/50263.pdf",
          "license": "none",
          "copyright": "none"
        },
        {
          "name": "Nuclear energy",
          "description": "Description of history and current situation of nuclear energy for electricity generation in Switzerland.",
          "url": "http://www.bfe.admin.ch/themen/00511/index.html?lang=en",
          "license": "none",
          "copyright": "Swiss federal authorities"
        },
        {
          "name": "National generation capacity",
          "description": "Open Source power system data, installed power generation capacities in Europe",
          "url": "https://data.open-power-system-data.org/national_generation_capacity/2019-02-22",
          "license": "none",
          "copyright": "none"
        },
        {
          "name": "FE08: Average Cost of Fuels and Energy Consumed by Enterprises by Type of Fuel/Energy",
          "description": "Fuel cost of oil shale in Estonia",
          "url": "http://pub.stat.ee/px-web.2001/Dialog/varval.asp?ma=FE08&lang=1",
          "license": "none",
          "copyright": "none"
        },
        {
          "name": "Statistics World - Total Primary Energy Supply (TPES) by source (table)",
          "description": "Electricity generation by source an country",
          "url": "https://www.iea.org/statistics/?country=WORLD&year=2016&category=Energy%20supply&indicator=TPESbySource&mode=table&dataTable=ELECTRICITYANDHEAT",
          "license": "non-exclusive",
          "copyright": "OECD/IEA"
        },
        {
          "name": "Nuclear Power in Poland",
          "description": "A history, status and look out on nuclear power in Poland.",
          "url": "https://www.world-nuclear.org/information-library/country-profiles/countries-o-s/poland.aspx",
          "license": "none",
          "copyright": "2016-2020 World Nuclear Association"
        },
        {
          "name": "Nuclear Power in Slovenia",
          "description": "A history, status and look out on nuclear power in Slovenia.",
          "url": "https://www.world-nuclear.org/information-library/country-profiles/countries-o-s/slovenia.aspx",
          "license": "none",
          "copyright": "2016-2020 World Nuclear Association"
        }
    ],
    "license":
        {"id": "CC-BY-4.0",
        "name": "Creative Commons Attribution 4.0 International",
        "version": "4.0",
        "url": "https://spdx.org/licenses/CC-BY-4.0.html",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!",
        "copyright": "© Hauke Henke"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2017-07-24", "comment": "Create table"},
        {"name": "Ludee", "email": "none", "date": "2017-11-14", "comment": "Update structure and metadata"},
        {"name": "Ludee", "email": "none", "date": "2018-01-30", "comment": "New naming structure"},
        {"name": "4lm", "email": "none", "date": "2019-07-16", "comment": "Update metadata"} ],
    "resources": [
        {"name": "model_draft.reeem_osembe_input",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "schema", "description": "1. classification", "unit": "none"},
            {"name": "category", "description": "2. classification", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "field", "description": "Old classification", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "source", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.1','setup','model_draft','reeem_osembe_input','reeem_db_setup_osembe.sql',' ');


-- OSeMBE Output
DROP TABLE IF EXISTS    model_draft.reeem_osembe_output CASCADE;
CREATE TABLE            model_draft.reeem_osembe_output (
    "id"            serial NOT NULL,
    "nid"           integer,
    "dfid"          integer,
    "pathway"       text,
    "framework"     text,
    "version"       text,
    "schema"        text,
    "category"      text,
    "tags"          hstore,
    "field"         text,
    "region"        text,
    "year"          smallint,
    "indicator"     text,
    "value"         double precision,
    "unit"          text,
    "aggregation"   boolean,
    "updated"       timestamp with time zone,
    "source"        text,
    CONSTRAINT reeem_osembe_output_pkey PRIMARY KEY (id) );

-- access rights
ALTER TABLE             model_draft.reeem_osembe_output OWNER TO reeem_user;
GRANT SELECT ON TABLE   model_draft.reeem_osembe_output TO reeem_read WITH GRANT OPTION;

-- metadata
COMMENT ON TABLE model_draft.reeem_osembe_output IS '{
    "title": "REEEM OSeMBE Output",
    "description": "Output parameters: ",
    "language": [ "eng" ],
    "spatial": 
        {"location": "none",
        "extent": "Europe (EU28+NO+CH)",
        "resolution": "Country"},
    "temporal": 
        {"reference_date": "2015",
        "start": "2015",
        "end": "2050",
        "resolution": "15 timeslices per year"},
    "sources": [
        {"name": "OSeMOSYS OSEMBE", "description": "The Open-Source energy Model Base for the European Union", "url": "http://www.osemosys.org/osembe.html", "license": "Apache License 2.0 (Apache-2.0)", "copyright": "tba"},
        {"name": "OSeMBE – An open-source engagement model", "description": "Model documentation", "url": "http://www.osemosys.org/uploads/1/8/5/0/18504136/osembe_documentation.pdf", "license": "none", "copyright": "none"},
        {"name": "OSeMBE input data", "description": "Data", "url": "http://www.osemosys.org/uploads/1/8/5/0/18504136/osembe_v1_20180821.zip", "license": "Open Data Commons Attribution License 1.0 (ODC-BY-1.0)", "copyright": "© Hauke Henke"}],
    "license": 
        {"id": "CC-BY-4.0",
        "name": "Creative Commons Attribution 4.0 International",
        "version": "4.0",
        "url": "https://spdx.org/licenses/CC-BY-4.0.html",
        "instruction": "You are free: To Share, To Create, To Adapt; As long as you: Attribute!",
        "copyright": "© Hauke Henke"},
    "contributors": [
        {"name": "Ludee", "email": "none", "date": "2017-07-24", "comment": "Create table"},
        {"name": "Ludee", "email": "none", "date": "2017-11-14", "comment": "Update structure and metadata"},
        {"name": "Ludee", "email": "none", "date": "2018-01-30", "comment": "New naming structure"},
        {"name": "Ludee", "email": "none", "date": "2018-10-09", "comment": "Update table name and metadata"},
        {"name": "4lm", "email": "none", "date": "2019-07-16", "comment": "Update metadata"} ],
    "resources": [
        {"name": "model_draft.reeem_osembe_output",
        "format": "PostgreSQL",
        "fields": [
            {"name": "id", "description": "Unique identifier", "unit": "none"},
            {"name": "nid", "description": "Row id", "unit": "none"},
            {"name": "dfid", "description": "Internal dataframe id", "unit": "none"},
            {"name": "pathway", "description": "REEEM pathway", "unit": "none"},
            {"name": "framework", "description": "REEEM framework", "unit": "none"},
            {"name": "version", "description": "REEEM version", "unit": "none"},
            {"name": "schema", "description": "1. classification", "unit": "none"},
            {"name": "category", "description": "2. classification", "unit": "none"},
            {"name": "tags", "description": "Free classification", "unit": "none"},
            {"name": "field", "description": "Old classification", "unit": "none"},
            {"name": "region", "description": "Country or region", "unit": "none"},
            {"name": "year", "description": "Year", "unit": "none"},
            {"name": "indicator", "description": "Parameter name", "unit": "none"},
            {"name": "value", "description": "Parameter value", "unit": "unit"},
            {"name": "unit", "description": "Parameter unit", "unit": "none"},
            {"name": "aggregation", "description": "True if aggregated", "unit": "none"},
            {"name": "updated", "description": "Timestamp", "unit": "none"},
            {"name": "source", "description": "Data source", "unit": "none"} ] } ],
    "metadata_version": "1.3"}';

-- scenario log (project,version,io,schema_name,table_name,script_name,comment)
SELECT scenario_log('REEEM','v0.1','setup','model_draft','reeem_osembe_output','reeem_db_setup_osembe.sql',' ');
