import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    avatar: String,
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    this.markers = []

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10" // <-- you can use your own!
    });

    this.#addMarkersToMap()
    this.#fitMapToMarkers()

    // this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
    // mapboxgl: mapboxgl }))
    setTimeout(() => {
      if (location.pathname === "/dashboard") {
        this.#getUserCoords()
        this.#handleClick()
<<<<<<< HEAD
        // this.#getInstructions()
=======
>>>>>>> f87d615da94b3669049cc1b5dce0a80350b546ca
      }
      this.map.resize()
    }, 2000);
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window);

      // Create a HTML element for your custom marker
      const customMarker = document.createElement("div")
      customMarker.className = "marker"
      customMarker.style.backgroundImage = `url('${marker.image_url}')`
      customMarker.style.backgroundColor = "black"
      customMarker.style.backgroundSize = "contain"
      customMarker.style.width = "25px"
      customMarker.style.height = "25px"

      // Pass the element as an argument to the new marker
      const mapMarker = new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)

      this.markers.push(mapMarker)
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    if (this.markersValue.length > 0) {

      this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 2000 })
    }
  }

  #getDirection(start) {
    this.map.loadImage(this.avatarValue, (err, img) => {
      this.map.addImage("human", img)
    })
    this.getRoute(start);
    // Add starting point to the map
    this.map.addLayer({
      id: 'point',
      type: 'symbol',
      layout: {
        "icon-image": "human",
        "icon-size": 0.028,
      },
      source: {
        type: 'geojson',
        data: {
          type: 'FeatureCollection',
          features: [
            {
              type: 'Feature',
              properties: {},
              geometry: {
                type: 'Point',
                coordinates: start
              }
            }
          ]
        }
      }
    });
    // Add end point to map
    const coords = [this.markersValue[0].lng, this.markersValue[0].lat]
    const end = {
      type: 'FeatureCollection',
      features: [
        {
          type: 'Feature',
          properties: {},
          geometry: {
            type: 'Point',
            coordinates: coords
          }
        }
      ]
    };
    if (this.map.getLayer('end')) {
      this.map.getSource('end').setData(end);
    } else {
      this.map.addLayer({
        id: 'end',
        type: 'circle',
        source: {
          type: 'geojson',
          data: {
            type: 'FeatureCollection',
            features: [
              {
                type: 'Feature',
                properties: {},
                geometry: {
                  type: 'Point',
                  coordinates: coords
                }
              }
            ]
          }
        },
        paint: {
          'circle-radius': 10,
          'circle-color': '#f30'
        }
      });
    }
    this.getRoute(coords);
  }

  #getUserCoords() {
    navigator.geolocation.getCurrentPosition((pos) => {
      const start = ([pos.coords.longitude, pos.coords.latitude])
      this.#getDirection(start)
    })
  }

  #handleClick() {
    this.map.on('click', event => {
      const coords = Object.keys(event.lngLat).map((key) => event.lngLat[key]);
      const end = {
        type: 'FeatureCollection',
        features: [
          {
            type: 'Feature',
            properties: {},
            geometry: {
              type: 'Point',
              coordinates: coords
            }
          }
        ]
      };

      if (this.map.getLayer('end')) {
        this.map.getSource('end').setData(end);
      } else {
        this.map.addLayer({
          id: 'end',
          type: 'circle',
          source: {
            type: 'geojson',
            data: {
              type: 'FeatureCollection',
              features: [
                {
                  type: 'Feature',
                  properties: {},
                  geometry: {
                    type: 'Point',
                    coordinates: coords
                  }
                }
              ]
            }
          },
          paint: {
            'circle-radius': 10,
            'circle-color': '#f30'
          }
        });
      }
      this.getRoute(coords);
    })
  }
  #getInstructions(data) {
    const instructions = document.getElementById('instructions');
    const steps = data.legs[0].steps;

    let tripInstructions = '';
    for (const step of steps) {
      tripInstructions += `<li>${step.maneuver.instruction}</li>`;
    }
    instructions.innerHTML = `<p><strong>Trip Duration: ${Math.floor(
      data.duration / 60
    )} mins 🚗 </strong></p><ol>${tripInstructions}</ol>`;
  }

  // create a function to make a directions request
  async getRoute(end) {
    // make a directions request using cycling profile
    // an arbitrary start will always be the same
    // only the end or destination will change
    const start = [115.130468, -8.654085];
    const query = await fetch(
      `https://api.mapbox.com/directions/v5/mapbox/driving/${start[0]},${start[1]};${end[0]},${end[1]}?steps=true&geometries=geojson&access_token=${mapboxgl.accessToken}`,
      { method: 'GET' }
    );
    const json = await query.json();
    const data = json.routes[0];
    const route = data.geometry.coordinates;
    const geojson = {
      type: 'Feature',
      properties: {},
      geometry: {
        type: 'LineString',
        coordinates: route
      }
    };
    // if the route already exists on the map, we'll reset it using setData
    if (this.map.getSource('route')) {
      this.map.getSource('route').setData(geojson);
    }
    // otherwise, we'll make a new request
    else {
      this.map.addLayer({
        id: 'route',
        type: 'line',
        source: {
          type: 'geojson',
          data: geojson
        },
        layout: {
          'line-join': 'round',
          'line-cap': 'round'
        },
        paint: {
          'line-color': '#3887be',
          'line-width': 5,
          'line-opacity': 0.75
        }
      });
    }
    // add turn instructions here at the end
    this.#getInstructions(data)
  }
}
