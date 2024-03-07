import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit"
export default class extends Controller {
  static targets = ["toEdit"];

  connect() {
    console.log("CONNECTED FROM edit controller");
  }

  toggle() {
    console.log("works");
    this.toEditTarget.classList.toggle("d-none")
  }
}
