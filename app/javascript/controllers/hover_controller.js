import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="hover"
export default class extends Controller {
  static targets = ["appear"]

  connect() {
    console.log("hover controller");
  }

  see() {
    this.appearTarget.classList.remove("d-none")
  }

  hide() {
    this.appearTarget.classList.add("d-none")
  }

}
