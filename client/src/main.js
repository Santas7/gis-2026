import './style.css';
import 'ol/ol.css';

import Map from 'ol/Map';
import View from 'ol/View';
import TileLayer from 'ol/layer/Tile';
import ImageLayer from 'ol/layer/Image';
import OSM from 'ol/source/OSM';
import ImageWMS from 'ol/source/ImageWMS';
import { fromLonLat } from 'ol/proj';

const geoserverWmsUrl = 'http://localhost:8080/geoserver/gis/wms';

const buildingsLayer = new ImageLayer({
  source: new ImageWMS({
    url: geoserverWmsUrl,
    params: {
      LAYERS: 'gis:buildings',
      TILED: true
    },
    ratio: 1,
    serverType: 'geoserver'
  }),
  opacity: 0.7
});

const roadsLayer = new ImageLayer({
  source: new ImageWMS({
    url: geoserverWmsUrl,
    params: {
      LAYERS: 'gis:roads',
      TILED: true
    },
    ratio: 1,
    serverType: 'geoserver'
  })
});

const poiLayer = new ImageLayer({
  source: new ImageWMS({
    url: geoserverWmsUrl,
    params: {
      LAYERS: 'gis:poi',
      TILED: true
    },
    ratio: 1,
    serverType: 'geoserver'
  })
});

new Map({
  target: 'map',
  layers: [
    new TileLayer({
      source: new OSM()
    }),
    buildingsLayer,
    roadsLayer,
    poiLayer
  ],
  view: new View({
    // Если данные не по Самаре — поменяй координаты
    center: fromLonLat([50.15, 53.20]),
    zoom: 13
  })
});