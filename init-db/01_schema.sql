--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg110+2)
-- Dumped by pg_dump version 16.4 (Debian 16.4-1.pgdg110+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: buildings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.buildings (
    gid bigint NOT NULL,
    ogc_fid integer,
    "timestamp" timestamp with time zone,
    version character varying,
    changeset character varying,
    "user" character varying,
    uid character varying,
    "addr:city" character varying,
    "addr:housenumber" character varying,
    "addr:place" character varying,
    "addr:street" character varying,
    building character varying,
    "building:levels" character varying,
    highway character varying,
    id character varying,
    geom public.geometry(MultiPolygon,4326)
);


--
-- Name: poi; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.poi (
    gid bigint NOT NULL,
    ogc_fid integer,
    "timestamp" timestamp with time zone,
    version character varying,
    changeset character varying,
    "user" character varying,
    uid character varying,
    "addr:city" character varying,
    "addr:housenumber" character varying,
    "addr:place" character varying,
    "addr:street" character varying,
    building character varying,
    "building:levels" character varying,
    highway character varying,
    id character varying,
    geom public.geometry(MultiPoint,4326)
);


--
-- Name: roads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roads (
    gid bigint NOT NULL,
    ogc_fid integer,
    "timestamp" timestamp with time zone,
    version character varying,
    changeset character varying,
    "user" character varying,
    uid character varying,
    "addr:city" character varying,
    "addr:housenumber" character varying,
    "addr:place" character varying,
    "addr:street" character varying,
    building character varying,
    "building:levels" character varying,
    highway character varying,
    id character varying,
    geom public.geometry(MultiLineString,4326)
);


--
-- Name: buildings buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buildings
    ADD CONSTRAINT buildings_pkey PRIMARY KEY (gid);


--
-- Name: poi poi_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.poi
    ADD CONSTRAINT poi_pkey PRIMARY KEY (gid);


--
-- Name: roads roads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roads
    ADD CONSTRAINT roads_pkey PRIMARY KEY (gid);


--
-- Name: idx_buildings_geom; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_buildings_geom ON public.buildings USING gist (geom);


--
-- Name: idx_poi_geom; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_poi_geom ON public.poi USING gist (geom);


--
-- Name: idx_roads_geom; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_roads_geom ON public.roads USING gist (geom);


--
-- PostgreSQL database dump complete
--

