import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="switch"
export default class extends Controller {
  connect() {
    console.log("CONNECTED FROM SWITCH");
  }
}
