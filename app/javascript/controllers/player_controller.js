import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["count", "input"];

  connect() {
    console.log("coucou");
    this.inputTargets.forEach((element) => {
      element.value = 0
    });
    // this.countTarget.textContent = "0";
  }

  increment(event) {
    if (event.currentTarget.closest(".input-group").querySelector('p').innerText === "Min player") {
      this.count = this.element.querySelector(".minus")
    } else {
      this.count = this.element.querySelector(".plus")
    }

    if (event.currentTarget.classList.contains("player-btn-plus")) {
      this.input = event.target.form[9]
    } else {
      this.input = event.target.form[12]
    }
    let currentValue = parseInt(this.count.textContent);
    this.count.textContent = currentValue + 1;
    this.input.value = this.count.textContent
  }

  decrement(event) {
    if (event.currentTarget.closest(".input-group").querySelector('p').innerText === "Min player") {
      this.count = this.element.querySelector(".minus")
    } else {
      this.count = this.element.querySelector(".plus")
    }

    if (event.currentTarget.classList.contains("player-btn-plus")) {
      this.input = event.target.form[9]
    } else {
      this.input = event.target.form[12]
    }
    let currentValue = parseInt(this.count.textContent);
    this.count.textContent = currentValue - 1;
    this.input.value = this.count.textContent
  }
}
