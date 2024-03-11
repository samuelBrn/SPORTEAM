// search_toggle_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  toggleModal() {
    const searchModal = document.getElementById("searchModal");

    if (searchModal.classList.contains("show")) {
      searchModal.classList.remove("show");
      searchModal.style.display = "none";
    } else {
      searchModal.classList.add("show");
      searchModal.style.display = "block";
    }
  }
}
