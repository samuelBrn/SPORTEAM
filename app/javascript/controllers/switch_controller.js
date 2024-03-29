import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tabs", "cards", "map"]

  handleClick(event) {
    if (event.params.toggabletarget === "map") {
      this.showCards()
    } else {
      this.showMap()
    }
  }

  showMap() {
    this.mapTarget.classList.remove("d-none")
    this.cardsTarget.classList.add("d-none")

    this.mapTarget.classList.remove("btn btn-toggle active")
    this.cardsTarget.classList.add("btn btn-toggle")

    // this.tabsTarget.children[0].classList.remove("btn-primary")
    // this.tabsTarget.children[0].classList.add("btn-outline-primary")
    this.tabsTarget.children[1].classList.remove("btn-outline-primary")
    this.tabsTarget.children[1].classList.add("btn-primary")
  }

  showCards() {
    this.mapTarget.classList.add("d-none")
    this.cardsTarget.classList.remove("d-none")

    this.cardsTarget.classList.remove("btn btn-toggle active")
    this.mapTarget.classList.add("btn btn-toggle")

    // this.tabsTarget.children[0].classList.add("btn-primary")
    // this.tabsTarget.children[0].classList.remove("btn-outline-primary")
    this.tabsTarget.children[1].classList.add("btn-outline-primary")
    this.tabsTarget.children[1].classList.remove("btn-primary")
  }
}
