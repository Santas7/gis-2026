DROP TABLE IF EXISTS buildings CASCADE;
DROP TABLE IF EXISTS roads CASCADE;
DROP TABLE IF EXISTS poi CASCADE;


CREATE TABLE buildings AS
SELECT
    row_number() OVER () AS gid,
    t.*
FROM tmp_layer t
WHERE t.building IS NOT NULL
  AND GeometryType(t.geom) IN ('POLYGON', 'MULTIPOLYGON');

ALTER TABLE buildings ADD PRIMARY KEY (gid);

ALTER TABLE buildings
ALTER COLUMN geom
TYPE geometry(MultiPolygon, 4326)
USING ST_Multi(
    CASE
        WHEN ST_SRID(geom) = 0 THEN ST_SetSRID(geom, 4326)
        WHEN ST_SRID(geom) = 4326 THEN geom
        ELSE ST_Transform(geom, 4326)
    END
)::geometry(MultiPolygon, 4326);

CREATE INDEX idx_buildings_geom
ON buildings
USING GIST (geom);


CREATE TABLE roads AS
SELECT
    row_number() OVER () AS gid,
    t.*
FROM tmp_layer t
WHERE t.highway IS NOT NULL
  AND GeometryType(t.geom) IN ('LINESTRING', 'MULTILINESTRING');

ALTER TABLE roads ADD PRIMARY KEY (gid);

ALTER TABLE roads
ALTER COLUMN geom
TYPE geometry(MultiLineString, 4326)
USING ST_Multi(
    CASE
        WHEN ST_SRID(geom) = 0 THEN ST_SetSRID(geom, 4326)
        WHEN ST_SRID(geom) = 4326 THEN geom
        ELSE ST_Transform(geom, 4326)
    END
)::geometry(MultiLineString, 4326);

CREATE INDEX idx_roads_geom
ON roads
USING GIST (geom);

-- POI
CREATE TABLE poi AS
SELECT
    row_number() OVER () AS gid,
    t.*
FROM tmp_layer t
WHERE GeometryType(t.geom) IN ('POINT', 'MULTIPOINT');

ALTER TABLE poi ADD PRIMARY KEY (gid);

ALTER TABLE poi
ALTER COLUMN geom
TYPE geometry(MultiPoint, 4326)
USING ST_Multi(
    CASE
        WHEN ST_SRID(geom) = 0 THEN ST_SetSRID(geom, 4326)
        WHEN ST_SRID(geom) = 4326 THEN geom
        ELSE ST_Transform(geom, 4326)
    END
)::geometry(MultiPoint, 4326);

CREATE INDEX idx_poi_geom
ON poi
USING GIST (geom);

ANALYZE buildings;
ANALYZE roads;
ANALYZE poi;