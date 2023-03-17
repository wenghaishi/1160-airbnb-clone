import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  static targets = ["mapWrapper", "showMap", "showList"]

  connect() {
    mapboxgl.accessToken = this.apiKeyValue


    this.map = new mapboxgl.Map({
      container: this.mapWrapperTarget,
      style: "mapbox://styles/mapbox/light-v11",
      projection: 'mercator'
    })

    this.map.on("load", () => {
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
      this.#addMapControls()
    })

  }

  showMap() {
    this.mapWrapperTarget.classList.toggle("show")
    this.showListTarget.classList.toggle("hidden")
    this.showMapTarget.classList.toggle("hidden")
    this.map.resize()
  }
  showList() {
    this.mapWrapperTarget.classList.toggle("show")
    this.showMapTarget.classList.toggle("hidden")
    this.showListTarget.classList.toggle("hidden")
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      // Create a HTML element for your custom marker
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  #addMapControls() {
    this.map.addControl(new mapboxgl.NavigationControl())
  }
}
