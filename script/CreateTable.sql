
--
-- Name: linkorgs; Type: SCHEMA; Schema: -;
--

CREATE SCHEMA linkorgs;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: datasets; Type: TABLE; Schema: linkorgs; Owner: nicola
--

CREATE TABLE linkorgs.datasets (
    ckan_api text NOT NULL,
    portallink text NOT NULL,
    metadata jsonb NOT NULL,
    name text DEFAULT 'err0r'::text
);



CREATE TABLE linkorgs.links (
    id integer NOT NULL,
    fk_ckan_api text NOT NULL,
    wiki_url text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip inet NOT NULL
);


CREATE SEQUENCE linkorgs.links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: links_id_seq; Type: SEQUENCE OWNED BY; Schema: linkorgs; Owner: nicola
--

ALTER SEQUENCE linkorgs.links_id_seq OWNED BY linkorgs.links.id;


--
-- Name: v_app; Type: VIEW; Schema: linkorgs; Owner: nicola
--

CREATE VIEW linkorgs.v_app AS
SELECT
    NULL::text AS wiki_url,
    NULL::bigint AS count,
    NULL::bigint AS sum,
    NULL::text AS ckan_api,
    NULL::integer AS id;


--
-- Name: VIEW v_app; Type: COMMENT; Schema: linkorgs; Owner: nicola
--

COMMENT ON VIEW linkorgs.v_app IS 'Data Necessary for depicting the datasets';


--
-- Name: votes; Type: TABLE; Schema: linkorgs; Owner: nicola
--

CREATE TABLE linkorgs.votes (
    id integer NOT NULL,
    fk_link_id integer NOT NULL,
    direction smallint NOT NULL,
    voted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip inet NOT NULL
);

--
-- Name: votes_id_seq; Type: SEQUENCE; Schema: linkorgs; Owner: nicola
--

CREATE SEQUENCE linkorgs.votes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: linkorgs; Owner: nicola
--

ALTER SEQUENCE linkorgs.votes_id_seq OWNED BY linkorgs.votes.id;


--
-- Name: links id; Type: DEFAULT; Schema: linkorgs; Owner: nicola
--

ALTER TABLE ONLY linkorgs.links ALTER COLUMN id SET DEFAULT nextval('linkorgs.links_id_seq'::regclass);


--
-- Name: votes id; Type: DEFAULT; Schema: linkorgs; Owner: nicola
--

ALTER TABLE ONLY linkorgs.votes ALTER COLUMN id SET DEFAULT nextval('linkorgs.votes_id_seq'::regclass);


--
-- Data for Name: datasets; Type: TABLE DATA; Schema: linkorgs; Owner: nicola
--

INSERT INTO linkorgs.datasets VALUES ('http://localhost:5000/api/3/action/package_show?id=fffde6d1-d932-4bde-ad5b-87816d47a91c', 'not implemented yet lol', '{"help": "http://localhost:5000/api/3/action/help_show?name=package_show", "result": {"id": "fffde6d1-d932-4bde-ad5b-87816d47a91c", "url": null, "name": "oh_rechnungsabschluss-ganserndorf-2004", "tags": [{"id": "5467cedf-49db-402e-87fa-16507498739e", "name": "Ausgaben", "state": "active", "display_name": "Ausgaben", "vocabulary_id": null}, {"id": "a878cc8f-38e9-45f7-bf70-84d39d429416", "name": "Einnahmen", "state": "active", "display_name": "Einnahmen", "vocabulary_id": null}, {"id": "0591d4ac-1acf-49b7-b9fe-9ec3d28efd4d", "name": "Gemeinde", "state": "active", "display_name": "Gemeinde", "vocabulary_id": null}, {"id": "8e70a660-39e5-4aaa-b226-fa6eb80f88a2", "name": "Gemeindefinanzen", "state": "active", "display_name": "Gemeindefinanzen", "vocabulary_id": null}, {"id": "50826803-8876-4008-b941-488a614ff1aa", "name": "Haushalt", "state": "active", "display_name": "Haushalt", "vocabulary_id": null}, {"id": "8a0d023e-5f26-496b-bbb5-c658d4f6ce2f", "name": "Offenerhaushalt.at", "state": "active", "display_name": "Offenerhaushalt.at", "vocabulary_id": null}, {"id": "522c2589-c9f3-437a-9147-df2440748d3a", "name": "Rechnungsabschluss", "state": "active", "display_name": "Rechnungsabschluss", "vocabulary_id": null}], "type": "dataset", "notes": "Rechnungsabschluss der Gemeinde - Einnahmen und Ausgaben", "state": "active", "title": "Rechnungsabschluss Gänserndorf 2004 (Statistik Austria)", "author": null, "extras": [{"key": "metadata_origin_portal", "value": "https://data.offenerhaushalt.at"}], "groups": [{"id": "3dbc23aa-c7dc-4f73-b126-84146312d6e6", "name": "testgrp", "title": "TestGrp", "description": "", "display_name": "TestGrp", "image_display_url": ""}], "isopen": false, "private": false, "version": null, "num_tags": 7, "owner_org": "2930682a-9e78-4af6-aac5-e25306d37bb3", "resources": [{"id": "23dcb5e5-e596-412b-a14f-e970224a6a41", "url": "https://www.offenerhaushalt.at/data/download/30817_2004_STA_RA", "hash": "", "name": "Rechnungsabschluss Gänserndorf 2004 (Statistik Austria)", "size": null, "state": "active", "format": "CSV", "created": "2017-11-13T00:00:00", "mimetype": null, "position": 0, "url_type": null, "cache_url": null, "package_id": "fffde6d1-d932-4bde-ad5b-87816d47a91c", "description": "", "revision_id": "1b21474d-5aa7-4024-b8d0-c633c7f9af58", "last_modified": "2017-11-13T00:00:00", "resource_type": null, "mimetype_inner": null, "datastore_active": false, "cache_last_updated": null}], "license_id": "cc-by-40", "maintainer": "Gänserndorf", "revision_id": "1b21474d-5aa7-4024-b8d0-c633c7f9af58", "author_email": null, "organization": {"id": "2930682a-9e78-4af6-aac5-e25306d37bb3", "name": "open-data-austria", "type": "organization", "state": "active", "title": "Open Data Austria", "created": "2020-07-23T14:03:41.165253", "image_url": "", "description": "", "revision_id": "7cbd43b1-6dba-438d-a64a-a01677f5a147", "approval_status": "approved", "is_organization": true}, "license_title": "cc-by-40", "num_resources": 1, "creator_user_id": "913f3dcb-24c8-4c43-a877-214bbb27e2d7", "maintainer_email": null, "metadata_created": "2020-07-23T21:17:30.688921", "metadata_modified": "2020-07-23T21:17:30.688934", "relationships_as_object": [], "relationships_as_subject": []}, "success": true}', 'Also not implemented');
INSERT INTO linkorgs.datasets VALUES ('http://localhost:5000/api/3/action/package_show?id=fff93efa-d5ba-425b-9908-a71f0c1c98e1', 'http://localhost:5000/dataset/oh_rechnungsabschluss-furstenfeld-2005', '{"help": "http://localhost:5000/api/3/action/help_show?name=package_show", "result": {"id": "fff93efa-d5ba-425b-9908-a71f0c1c98e1", "url": null, "name": "oh_rechnungsabschluss-furstenfeld-2005", "tags": [{"id": "5467cedf-49db-402e-87fa-16507498739e", "name": "Ausgaben", "state": "active", "display_name": "Ausgaben", "vocabulary_id": null}, {"id": "a878cc8f-38e9-45f7-bf70-84d39d429416", "name": "Einnahmen", "state": "active", "display_name": "Einnahmen", "vocabulary_id": null}, {"id": "0591d4ac-1acf-49b7-b9fe-9ec3d28efd4d", "name": "Gemeinde", "state": "active", "display_name": "Gemeinde", "vocabulary_id": null}, {"id": "8e70a660-39e5-4aaa-b226-fa6eb80f88a2", "name": "Gemeindefinanzen", "state": "active", "display_name": "Gemeindefinanzen", "vocabulary_id": null}, {"id": "50826803-8876-4008-b941-488a614ff1aa", "name": "Haushalt", "state": "active", "display_name": "Haushalt", "vocabulary_id": null}, {"id": "8a0d023e-5f26-496b-bbb5-c658d4f6ce2f", "name": "Offenerhaushalt.at", "state": "active", "display_name": "Offenerhaushalt.at", "vocabulary_id": null}, {"id": "522c2589-c9f3-437a-9147-df2440748d3a", "name": "Rechnungsabschluss", "state": "active", "display_name": "Rechnungsabschluss", "vocabulary_id": null}], "type": "dataset", "notes": "Rechnungsabschluss der Gemeinde - Einnahmen und Ausgaben", "state": "active", "title": "Rechnungsabschluss Fürstenfeld 2005 (Statistik Austria)", "author": null, "extras": [{"key": "metadata_origin_portal", "value": "https://data.offenerhaushalt.at"}], "groups": [], "isopen": false, "private": false, "version": null, "num_tags": 7, "owner_org": "2930682a-9e78-4af6-aac5-e25306d37bb3", "resources": [{"id": "b10cd0b6-0c4f-45e0-99c1-10132ff4828d", "url": "https://www.offenerhaushalt.at/data/download/62267_2005_STA_RA", "hash": "", "name": "Rechnungsabschluss Fürstenfeld 2005 (Statistik Austria)", "size": null, "state": "active", "format": "CSV", "created": "2017-11-13T00:00:00", "mimetype": null, "position": 0, "url_type": null, "cache_url": null, "package_id": "fff93efa-d5ba-425b-9908-a71f0c1c98e1", "description": "", "revision_id": "8e573417-0d82-4663-9ff0-331b774a4d5e", "last_modified": "2017-11-13T00:00:00", "resource_type": null, "mimetype_inner": null, "datastore_active": false, "cache_last_updated": null}], "license_id": "cc-by-40", "maintainer": "Fürstenfeld", "revision_id": "8e573417-0d82-4663-9ff0-331b774a4d5e", "author_email": null, "organization": {"id": "2930682a-9e78-4af6-aac5-e25306d37bb3", "name": "open-data-austria", "type": "organization", "state": "active", "title": "Open Data Austria", "created": "2020-07-23T14:03:41.165253", "image_url": "", "description": "", "revision_id": "7cbd43b1-6dba-438d-a64a-a01677f5a147", "approval_status": "approved", "is_organization": true}, "license_title": "cc-by-40", "num_resources": 1, "creator_user_id": "913f3dcb-24c8-4c43-a877-214bbb27e2d7", "maintainer_email": null, "metadata_created": "2020-07-23T21:17:29.321537", "metadata_modified": "2020-07-23T21:17:29.321549", "relationships_as_object": [], "relationships_as_subject": []}, "success": true}', '');
INSERT INTO linkorgs.datasets VALUES ('http://localhost:5000/api/3/action/package_show?id=fff27cd6-426c-479f-ae66-077ae6f1437d', 'http://localhost:5000/dataset/stadt-wien_wahleninwiengemeinderatswahlen', '{"help": "http://localhost:5000/api/3/action/help_show?name=package_show", "result": {"id": "fff27cd6-426c-479f-ae66-077ae6f1437d", "url": "", "name": "stadt-wien_wahleninwiengemeinderatswahlen", "tags": [{"id": "e4163388-7d27-4118-9273-558af5576a71", "name": "Gemeinderatswahl", "state": "active", "display_name": "Gemeinderatswahl", "vocabulary_id": null}, {"id": "5408acad-2b2f-4c45-8bd2-0eeaa576bbf7", "name": "Gemeinderatswahlen", "state": "active", "display_name": "Gemeinderatswahlen", "vocabulary_id": null}, {"id": "e8b62f1f-481c-452a-91b3-108aa6eb721b", "name": "Wahl", "state": "active", "display_name": "Wahl", "vocabulary_id": null}, {"id": "ca1237dc-70b7-4562-b63c-573749bd279a", "name": "Wahlen", "state": "active", "display_name": "Wahlen", "vocabulary_id": null}, {"id": "2a63d038-7ad7-4fd9-83fe-cc7f19d70858", "name": "Wahlergebnis", "state": "active", "display_name": "Wahlergebnis", "vocabulary_id": null}], "type": "dataset", "notes": "Ergebnisse der Gemeinderatswahlen in Wien.\r\nDer Ergebnisbestand einer Wahl wird immer erst nach der Sitzung der Stadtwahlbehörde auf data.gv.at veröffentlicht. Vorläufige Wahlergebnisse finden Sie im Ergebnisbestand der jeweiligen Wahl unter Rohdaten auf folgender Internetseite: www.wien.gv.at/politik/wahlen.", "state": "active", "title": "Gemeinderatswahlen Wien", "author": null, "extras": [{"key": "metadata_created", "value": "2020-04-15T14:12:20.873207"}], "groups": [], "isopen": false, "private": false, "version": null, "num_tags": 5, "owner_org": "2930682a-9e78-4af6-aac5-e25306d37bb3", "resources": [{"id": "fae5025f-2b21-4012-b0ca-07d7f5033fdc", "url": "https://www.wien.gv.at/politik/wahlen/ogd/gr051_99999999_9999_wvb.csv", "hash": "", "name": "GR05-wahlkreisverband", "size": null, "state": "active", "format": "CSV", "created": "2013-12-09T00:00:00", "mimetype": null, "position": 0, "url_type": null, "cache_url": null, "package_id": "fff27cd6-426c-479f-ae66-077ae6f1437d", "description": "", "revision_id": "aefda6ab-da9b-4649-925e-d26f8332e71a", "last_modified": "2013-12-09T00:00:00", "resource_type": null, "mimetype_inner": null, "datastore_active": true, "cache_last_updated": null}, {"id": "a01fe992-600c-4d02-aa65-0a4de56c3934", "url": "https://www.wien.gv.at/politik/wahlen/ogd/gr051_99999999_9999_spr.csv", "hash": "", "name": "GR05-wahlsprengel", "size": null, "state": "active", "format": "CSV", "created": "2013-12-09T00:00:00", "encoding": "None", "language": "None", "mimetype": null, "position": 1, "url_type": null, "cache_url": null, "package_id": "fff27cd6-426c-479f-ae66-077ae6f1437d", "description": "", "revision_id": "aefda6ab-da9b-4649-925e-d26f8332e71a", "last_modified": "2013-12-09T00:00:00", "resource_type": null, "mimetype_inner": null, "datastore_active": true, "cache_last_updated": null}, {"id": "8ba5ef43-0e86-4625-9993-4e2e00e440f4", "url": "https://www.wien.gv.at/politik/wahlen/ogd/gr101_99999999_9999_wvb.csv", "hash": "", "name": "GR10-wahlkreisverband", "size": null, "state": "active", "format": "CSV", "created": "2013-12-09T00:00:00", "mimetype": null, "position": 2, "url_type": null, "cache_url": null, "package_id": "fff27cd6-426c-479f-ae66-077ae6f1437d", "description": "", "revision_id": "aefda6ab-da9b-4649-925e-d26f8332e71a", "last_modified": "2013-12-09T00:00:00", "resource_type": null, "mimetype_inner": null, "datastore_active": true, "cache_last_updated": null}, {"id": "948159db-f593-49b0-a23a-29072a450179", "url": "https://www.wien.gv.at/politik/wahlen/ogd/gr101_99999999_9999_spr.csv", "hash": "", "name": "GR10-sprengel", "size": null, "state": "active", "format": "CSV", "created": "2013-12-09T00:00:00", "encoding": "None", "language": "None", "mimetype": null, "position": 3, "url_type": null, "cache_url": null, "package_id": "fff27cd6-426c-479f-ae66-077ae6f1437d", "description": "", "revision_id": "aefda6ab-da9b-4649-925e-d26f8332e71a", "last_modified": "2013-12-09T00:00:00", "resource_type": null, "mimetype_inner": null, "datastore_active": true, "cache_last_updated": null}, {"id": "85bdcfad-7182-434c-a997-93a09c14e0f5", "url": "https://www.wien.gv.at/politik/wahlen/ogd/gr151_99999999_9999_wvb.csv", "hash": "", "name": "GR15-wahlkreisverband", "size": null, "state": "active", "format": "CSV", "created": "2015-11-06T00:00:00", "encoding": "None", "language": "None", "mimetype": null, "position": 4, "url_type": null, "cache_url": null, "package_id": "fff27cd6-426c-479f-ae66-077ae6f1437d", "description": "", "revision_id": "aefda6ab-da9b-4649-925e-d26f8332e71a", "last_modified": "2015-11-06T00:00:00", "resource_type": null, "mimetype_inner": null, "datastore_active": true, "cache_last_updated": null}, {"id": "c2ff950a-a4bb-4edb-a363-3e3139488d59", "url": "https://www.wien.gv.at/politik/wahlen/ogd/gr151_99999999_9999_spr.csv", "hash": "", "name": "GR15-sprengel", "size": null, "state": "active", "format": "CSV", "created": "2015-11-06T00:00:00", "encoding": "None", "language": "None", "mimetype": null, "position": 5, "url_type": null, "cache_url": null, "package_id": "fff27cd6-426c-479f-ae66-077ae6f1437d", "description": "", "revision_id": "aefda6ab-da9b-4649-925e-d26f8332e71a", "last_modified": "2015-11-06T00:00:00", "resource_type": null, "mimetype_inner": null, "datastore_active": true, "cache_last_updated": null}], "license_id": "cc-by-40", "maintainer": "Magistrat Wien - Magistratsabteilung 62 - Wahlen und verschiedene Rechtsangelegenheiten", "revision_id": "aefda6ab-da9b-4649-925e-d26f8332e71a", "author_email": null, "organization": {"id": "2930682a-9e78-4af6-aac5-e25306d37bb3", "name": "open-data-austria", "type": "organization", "state": "active", "title": "Open Data Austria", "created": "2020-07-23T14:03:41.165253", "image_url": "", "description": "", "revision_id": "7cbd43b1-6dba-438d-a64a-a01677f5a147", "approval_status": "approved", "is_organization": true}, "license_title": "cc-by-40", "num_resources": 6, "creator_user_id": "913f3dcb-24c8-4c43-a877-214bbb27e2d7", "maintainer_email": "post@ma62.wien.gv.at", "metadata_created": "2020-07-23T21:17:25.513885", "metadata_modified": "2020-07-23T21:17:25.513895", "relationships_as_object": [], "relationships_as_subject": []}, "success": true}', '');
INSERT INTO linkorgs.datasets VALUES ('http://localhost:5000/api/3/action/package_show?id=ffee169d-36e8-40bc-9794-20eb4f8640eb', 'http://localhost:5000/dataset/oh_rechnungsabschluss-wolbling-2009', '{"help": "http://localhost:5000/api/3/action/help_show?name=package_show", "result": {"id": "ffee169d-36e8-40bc-9794-20eb4f8640eb", "url": null, "name": "oh_rechnungsabschluss-wolbling-2009", "tags": [{"id": "5467cedf-49db-402e-87fa-16507498739e", "name": "Ausgaben", "state": "active", "display_name": "Ausgaben", "vocabulary_id": null}, {"id": "a878cc8f-38e9-45f7-bf70-84d39d429416", "name": "Einnahmen", "state": "active", "display_name": "Einnahmen", "vocabulary_id": null}, {"id": "0591d4ac-1acf-49b7-b9fe-9ec3d28efd4d", "name": "Gemeinde", "state": "active", "display_name": "Gemeinde", "vocabulary_id": null}, {"id": "8e70a660-39e5-4aaa-b226-fa6eb80f88a2", "name": "Gemeindefinanzen", "state": "active", "display_name": "Gemeindefinanzen", "vocabulary_id": null}, {"id": "50826803-8876-4008-b941-488a614ff1aa", "name": "Haushalt", "state": "active", "display_name": "Haushalt", "vocabulary_id": null}, {"id": "8a0d023e-5f26-496b-bbb5-c658d4f6ce2f", "name": "Offenerhaushalt.at", "state": "active", "display_name": "Offenerhaushalt.at", "vocabulary_id": null}, {"id": "522c2589-c9f3-437a-9147-df2440748d3a", "name": "Rechnungsabschluss", "state": "active", "display_name": "Rechnungsabschluss", "vocabulary_id": null}], "type": "dataset", "notes": "Rechnungsabschluss der Gemeinde - Einnahmen und Ausgaben", "state": "active", "title": "Rechnungsabschluss Wölbling 2009 (Statistik Austria)", "author": null, "extras": [{"key": "metadata_origin_portal", "value": "https://data.offenerhaushalt.at"}], "groups": [], "isopen": false, "private": false, "version": null, "num_tags": 7, "owner_org": "2930682a-9e78-4af6-aac5-e25306d37bb3", "resources": [{"id": "7f6f240f-f370-4572-a694-c055a8b20e46", "url": "https://www.offenerhaushalt.at/data/download/31948_2009_STA_RA", "hash": "", "name": "Rechnungsabschluss Wölbling 2009 (Statistik Austria)", "size": null, "state": "active", "format": "CSV", "created": "2017-11-13T00:00:00", "mimetype": null, "position": 0, "url_type": null, "cache_url": null, "package_id": "ffee169d-36e8-40bc-9794-20eb4f8640eb", "description": "", "revision_id": "6b8fbd1b-9202-451f-b1bd-af1681ca0921", "last_modified": "2017-11-13T00:00:00", "resource_type": null, "mimetype_inner": null, "datastore_active": false, "cache_last_updated": null}], "license_id": "cc-by-40", "maintainer": "Wölbling", "revision_id": "6b8fbd1b-9202-451f-b1bd-af1681ca0921", "author_email": null, "organization": {"id": "2930682a-9e78-4af6-aac5-e25306d37bb3", "name": "open-data-austria", "type": "organization", "state": "active", "title": "Open Data Austria", "created": "2020-07-23T14:03:41.165253", "image_url": "", "description": "", "revision_id": "7cbd43b1-6dba-438d-a64a-a01677f5a147", "approval_status": "approved", "is_organization": true}, "license_title": "cc-by-40", "num_resources": 1, "creator_user_id": "913f3dcb-24c8-4c43-a877-214bbb27e2d7", "maintainer_email": null, "metadata_created": "2020-07-23T21:17:23.567334", "metadata_modified": "2020-07-23T21:17:23.567344", "relationships_as_object": [], "relationships_as_subject": []}, "success": true}', '');
INSERT INTO linkorgs.datasets VALUES ('https://www.data.gv.at/katalog/api/3/action/package_show?id=bfbd1de6-f99a-4024-93cb-9e68274d0d36', 'https://www.data.gv.at/katalog/dataset/bfbd1de6-f99a-4024-93cb-9e68274d0d36', '{"help": "https://www.data.gv.at/katalog/api/3/action/help_show?name=package_show", "result": {"id": "bfbd1de6-f99a-4024-93cb-9e68274d0d36", "url": null, "name": "stadt-wien_gewerbeinwien", "tags": [{"id": "f59c5db5-49ff-488e-8204-c42fbb55a1ab", "name": "Gewerbe", "state": "active", "display_name": "Gewerbe", "vocabulary_id": null}, {"id": "4f2724e2-1d62-4df3-9d5f-3bdfa4f10ce0", "name": "Gewerbeberechtigungen", "state": "active", "display_name": "Gewerbeberechtigungen", "vocabulary_id": null}, {"id": "41d6fb4a-4e5b-42c8-8595-a94a5d28fb20", "name": "Gewerbestatistik", "state": "active", "display_name": "Gewerbestatistik", "vocabulary_id": null}], "type": "dataset", "notes": "Es werden die aufrechten Gewerbeberechtigungen in Österreich ohne personenbezogenen Daten zur Verfügung gestellt. Die Daten von Wien können mit NUTS=AT13 gefiltert werden\r\n", "state": "active", "title": "Gewerbe Wien", "author": null, "extras": [{"key": "metadata_created", "value": "2020-04-15T14:11:16.156539"}, {"key": "harvest_object_id", "value": "948ed986-adb5-443b-9324-0a28bb27cbc2"}, {"key": "harvest_source_id", "value": "71bd8927-6cd9-48b7-984f-ceed7e986e40"}, {"key": "harvest_source_title", "value": "Excelimport Stadt Wien"}], "groups": [], "isopen": true, "private": false, "version": null, "num_tags": 3, "owner_org": "53c0fbbc-7b94-47ea-aba6-b09c4b006ca3", "publisher": "Stadt Wien", "resources": [{"id": "9327e7ad-3b15-4bcb-8854-481f83d1e751", "url": "https://www.data.gv.at/katalog/dataset/bfbd1de6-f99a-4024-93cb-9e68274d0d36/resource/9327e7ad-3b15-4bcb-8854-481f83d1e751/download/xgisa-opendata-csv.zip", "hash": "", "name": "GISA CSV", "size": null, "state": "active", "format": "CSV", "created": "2019-01-04T00:00:00", "mimetype": "application/zip", "position": 0, "url_type": "upload", "cache_url": null, "package_id": "bfbd1de6-f99a-4024-93cb-9e68274d0d36", "description": "", "revision_id": "453b40e3-8abf-4534-8d83-d54203a06d5b", "last_modified": "2020-08-31T04:24:42.170640", "resource_type": null, "mimetype_inner": null, "datastore_active": false, "cache_last_updated": null}, {"id": "5bfc2051-b486-4b39-92a0-ec785498eaff", "url": "https://www.data.gv.at/katalog/dataset/bfbd1de6-f99a-4024-93cb-9e68274d0d36/resource/5bfc2051-b486-4b39-92a0-ec785498eaff/download/xgisa-opendata-js.zip", "hash": "", "name": "GISA JSON", "size": null, "state": "active", "format": "JSON", "created": "2019-01-04T00:00:00", "mimetype": "application/zip", "position": 1, "url_type": "upload", "cache_url": null, "package_id": "bfbd1de6-f99a-4024-93cb-9e68274d0d36", "description": "", "revision_id": "453b40e3-8abf-4534-8d83-d54203a06d5b", "last_modified": "2020-08-31T04:25:09.867454", "resource_type": null, "mimetype_inner": null, "datastore_active": false, "cache_last_updated": null}], "terms_url": "https://digitales.wien.gv.at/site/open-data/ogd-nutzungsbedingungen/", "license_id": "cc-by-40", "maintainer": "Bundesministerium für Digitalisierung und Wirtschaftsstandort", "license_url": "https://creativecommons.org/licenses/by/4.0/deed.de", "revision_id": "59f5560e-a93f-4498-9603-115f2506a964", "schema_name": "OGD Austria Metadata 2.4", "author_email": null, "organization": {"id": "53c0fbbc-7b94-47ea-aba6-b09c4b006ca3", "name": "stadt-wien", "type": "organization", "state": "active", "title": "Stadt Wien", "created": "2017-12-01T10:20:00.407223", "image_url": "http://www.data.gv.at/wp-content/uploads/logos-organisationen/stadt-wien.png", "description": "", "revision_id": "14547243-d987-443a-af4a-869bd321016f", "approval_status": "approved", "is_organization": true}, "license_title": "Creative Commons Namensnennung 4.0 International", "num_resources": 2, "begin_datetime": "2011-01-01", "categorization": "{wirtschaft-und-tourismus}", "publisher_link": "https://digitales.wien.gv.at/site/open-data/", "creator_user_id": "1ef312ca-5bd3-42cd-a704-5cb22d67fbbc", "geographic_bbox": "WGS84: POLYGON ((16.577511 48.322571, 16.18218 48.117668))", "lineage_quality": "Durch Gewerbebehörden erfasste Anträge von Gewerbetreibenden", "maintainer_link": "https://www.gisa.gv.at/", "publisher_email": "open@post.wien.gv.at ", "schema_language": "ger", "license_citation": "Datenquelle: Stadt Wien – https://data.wien.gv.at", "maintainer_email": "post.i7@bmdw.gv.at", "metadata_created": "2015-06-25T10:07:18.749785", "metadata_linkage": "https://digitales.wien.gv.at/site/blockchain/?ogd_package=bfbd1de6-f99a-4024-93cb-9e68274d0d36", "update_frequency": "monthly", "en_title_and_desc": "Existing and valid business registrations, excluding personal data.", "metadata_modified": "2020-08-31T04:25:09.878216", "geographic_toponym": "Österreich", "metadata_identifier": "bfbd1de6-f99a-4024-93cb-9e68274d0d36", "schema_characterset": "utf8", "attribute_description": "NUTS1: NUTS1-Region (Gruppen von Bundesländern);\r\nNUTS2: NUTS2-Region (Bundesland);\r\nNUTS3: NUTS3-Region (Gruppe von Bezirken);\r\nLAU1: Bezirk;\r\nLAU2: Gemeinde;\r\nADRESS_ART: 1: Standort; 2: Weitere Betriebsstätte; 3: Integrierter Betrieb;\r\nGEWERBESCHLUESSEL: Code;\r\nGEWERBEWORTLAUT;\r\nGEWERBEART: 1: reglementiertes Gewerbe; 2: freies Gewerbe, 3: nicht bewilligungspflichtiges gebundenes Gewerbe; 4: Handwerk; 5: konzessioniertes Gewerbe; \r\n            6: bewilligungspflichtiges gebundenes Gewerbe; 7: Teilgewerbe; 8: Nebengewerbe; 9: gewerbliche Ausübung eines Patentes;\r\nPOSTLEITZAHL;\r\nORTSCHAFT;\r\nRECHTSWIRKSAM: Datum der Rechtswirksamkeit. Format: \"yyyy-mm-dd\";\r\nRUHEND_VON: Datum, ab wann das Gewerbe als ruhend gemeldet ist. Format: \"yyyy-mm-dd\";\r\nINHABER_PERS_ART: Personenart des Gewerbeinhabers - 1: Natürliche Person; 2: Juristische Person;\r\n", "relationships_as_object": [], "metadata_original_portal": "", "relationships_as_subject": []}, "success": true}', '');


--
-- Data for Name: links; Type: TABLE DATA; Schema: linkorgs; Owner: nicola
--

INSERT INTO linkorgs.links VALUES (1, 'http://localhost:5000/api/3/action/package_show?id=ffee169d-36e8-40bc-9794-20eb4f8640eb', 'wikidata.org/blabla', '2020-08-26 13:32:31.770824+02', '10.2.3.4');
INSERT INTO linkorgs.links VALUES (2, 'http://localhost:5000/api/3/action/package_show?id=fff93efa-d5ba-425b-9908-a71f0c1c98e1', 'wikidata.com/blabliblub', '2020-08-27 13:27:12.262339+02', '10.2.4.5');
INSERT INTO linkorgs.links VALUES (3, 'http://localhost:5000/api/3/action/package_show?id=fff93efa-d5ba-425b-9908-a71f0c1c98e1', 'https://www.wikidata.org/wiki/Q278044', '2020-08-27 16:53:35.206726+02', '127.0.0.1');
INSERT INTO linkorgs.links VALUES (4, 'https://www.data.gv.at/katalog/api/3/action/package_show?id=bfbd1de6-f99a-4024-93cb-9e68274d0d36', 'https://www.wikidata.org/wiki/Q1884195', '2020-09-02 15:38:10.788229+02', '127.0.0.1');


--
-- Data for Name: votes; Type: TABLE DATA; Schema: linkorgs; Owner: nicola
--

INSERT INTO linkorgs.votes VALUES (1, 1, 1, '2020-08-26 13:34:09.480031+02', '10.2.3.4');
INSERT INTO linkorgs.votes VALUES (2, 2, -1, '2020-08-27 13:27:33.360765+02', '10.2.3.5');
INSERT INTO linkorgs.votes VALUES (3, 2, 1, '2020-08-27 15:44:51.467316+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (4, 2, -1, '2020-08-27 15:45:53.84811+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (5, 2, 1, '2020-08-27 15:48:16.911796+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (6, 2, 1, '2020-08-27 15:54:32.702955+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (7, 2, -1, '2020-08-27 15:57:08.337936+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (8, 2, -1, '2020-08-27 15:57:15.968861+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (10, 2, -1, '2020-08-27 17:23:56.540714+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (11, 3, 1, '2020-08-27 20:09:47.842286+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (12, 3, 1, '2020-08-27 20:11:22.076866+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (13, 3, -1, '2020-08-27 20:11:24.811656+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (14, 3, -1, '2020-08-27 20:13:00.086156+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (15, 3, -1, '2020-08-27 20:13:02.282269+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (16, 3, -1, '2020-08-27 20:13:03.775791+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (17, 3, 1, '2020-08-27 20:13:16.821728+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (18, 2, 1, '2020-08-27 20:13:24.75807+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (19, 3, 1, '2020-08-27 20:13:38.540006+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (20, 3, 1, '2020-08-27 20:13:41.786254+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (21, 3, 1, '2020-08-27 20:13:44.229134+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (22, 2, -1, '2020-08-28 15:00:22.492669+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (23, 3, -1, '2020-08-28 15:28:29.684656+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (24, 3, -1, '2020-08-28 15:28:40.815136+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (25, 4, 1, '2020-09-02 15:38:31.063548+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (26, 4, -1, '2020-09-02 15:38:35.512192+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (27, 4, 1, '2020-09-02 15:38:38.625373+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (28, 4, 1, '2020-09-02 15:38:40.459837+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (29, 4, -1, '2020-09-03 13:08:18.35432+02', '127.0.0.1');
INSERT INTO linkorgs.votes VALUES (30, 4, 1, '2020-09-03 13:08:24.197464+02', '127.0.0.1');


--
-- Name: links_id_seq; Type: SEQUENCE SET; Schema: linkorgs; Owner: nicola
--

SELECT pg_catalog.setval('linkorgs.links_id_seq', 4, true);


--
-- Name: votes_id_seq; Type: SEQUENCE SET; Schema: linkorgs; Owner: nicola
--

SELECT pg_catalog.setval('linkorgs.votes_id_seq', 30, true);


--
-- Name: datasets datasets_pkey; Type: CONSTRAINT; Schema: linkorgs; Owner: nicola
--

ALTER TABLE ONLY linkorgs.datasets
    ADD CONSTRAINT datasets_pkey PRIMARY KEY (ckan_api);


--
-- Name: datasets datasets_portallink_key; Type: CONSTRAINT; Schema: linkorgs; Owner: nicola
--

ALTER TABLE ONLY linkorgs.datasets
    ADD CONSTRAINT datasets_portallink_key UNIQUE (portallink);


--
-- Name: links links_pkey; Type: CONSTRAINT; Schema: linkorgs; Owner: nicola
--

ALTER TABLE ONLY linkorgs.links
    ADD CONSTRAINT links_pkey PRIMARY KEY (id);


--
-- Name: votes votes_pkey; Type: CONSTRAINT; Schema: linkorgs; Owner: nicola
--

ALTER TABLE ONLY linkorgs.votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: v_app _RETURN; Type: RULE; Schema: linkorgs; Owner: nicola
--

CREATE OR REPLACE VIEW linkorgs.v_app AS
 SELECT links.wiki_url,
    count(votes.*) AS count,
    COALESCE(sum(votes.direction), (0)::bigint) AS sum,
    datasets.ckan_api,
    links.id
   FROM ((linkorgs.datasets
     JOIN linkorgs.links ON ((datasets.ckan_api = links.fk_ckan_api)))
     LEFT JOIN linkorgs.votes ON ((links.id = votes.fk_link_id)))
  GROUP BY links.id, datasets.ckan_api;


--
-- Name: links ckan_api; Type: FK CONSTRAINT; Schema: linkorgs; Owner: nicola
--

ALTER TABLE ONLY linkorgs.links
    ADD CONSTRAINT ckan_api FOREIGN KEY (fk_ckan_api) REFERENCES linkorgs.datasets(ckan_api) ON UPDATE RESTRICT;


--
-- Name: votes links-votes; Type: FK CONSTRAINT; Schema: linkorgs; Owner: nicola
--

ALTER TABLE ONLY linkorgs.votes
    ADD CONSTRAINT "links-votes" FOREIGN KEY (fk_link_id) REFERENCES linkorgs.links(id) ON UPDATE RESTRICT;

