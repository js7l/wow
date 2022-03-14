import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "btn", "text", "icon" ]

  show() {
    this.iconTarget.classList.remove("far");
    this.iconTarget.classList.add("fas");
    this.textTarget.classList.remove("d-none");
  }
}
