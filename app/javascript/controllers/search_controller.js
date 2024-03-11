import { Controller } from "stimulus";

export default class extends Controller {
  toggleSearch() {
    document.querySelector(".search-form").classList.toggle("active");
  }
}
