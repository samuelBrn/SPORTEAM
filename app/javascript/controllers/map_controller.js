import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/dadopiece/cltr0v8m400zj01nr9tq6ek2a"
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      // const popup = new mapboxgl.Popup().setHTML(marker.info_window_html) // Add this

      const div = document.createElement('div');
      div.style.height = '40px'
      div.style.width = '40px'
      div.style.backgroundPosition = 'center';
      div.style.backgroundSize = 'cover';
      div.style.backgroundImage = `url(${marker.image})`;
      div.dataset.bsToggle = "offcanvas";
      div.dataset.bsTarget = `#event-${marker.event_id}`;

      // console.log(div)

      new mapboxgl.Marker(div)
        .setLngLat([ marker.lng, marker.lat ])
        // .setPopup(popup) // Add this
        .addTo(this.map)
    });
  }

  #fitMapToMarkers() {
    if (this.markersValue.length == 0) { return; }

    const bounds = new mapboxgl.LngLatBounds()

    this.markersValue.forEach((marker) => {
      bounds.extend([ marker.lng, marker.lat ])
    })

    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
