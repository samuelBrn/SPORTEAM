import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["categories"];

  toggle(evt) {
    evt.preventDefault();

    this.categoriesTarget.classList.toggle('d-none');
  }
}
