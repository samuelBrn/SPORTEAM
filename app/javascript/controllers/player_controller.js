import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["count", "input"];

  connect() {

  }

  increment(event) {
    const input = document.getElementById(event.currentTarget.dataset.inputid);
    input.value = Number.parseInt(input.value, 10) + 1;
    const span = this.countTargets.find(element => element.dataset.inputid === event.currentTarget.dataset.inputid );
    span.innerText = Number.parseInt(input.value, 10);
  }

  decrement(event) {
    const input = document.getElementById(event.currentTarget.dataset.inputid);
    if (Number.parseInt(input.value, 10) > 1) {
      input.value = Number.parseInt(input.value, 10) - 1;
      const span = this.countTargets.find(element => element.dataset.inputid === event.currentTarget.dataset.inputid );
      span.innerText = Number.parseInt(input.value, 10);
    }
  }
}
