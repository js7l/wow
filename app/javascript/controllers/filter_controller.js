import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  updateFilter() {
    if (window.scrollY >= 60.95) {
      this.element.classList.add("fixed-top")
    } else {
      this.element.classList.remove("fixed-top")
    }
  };
}
