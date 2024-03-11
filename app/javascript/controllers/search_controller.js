import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  connect() {
    document.querySelector(".search-form").classList.toggle("active");
  }

}
