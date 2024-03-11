import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["categories", 'submit'];

  filter(evt) {
    evt.preventDefault();
    console.log(evt)
    this.submitTarget.click();
  }
}
