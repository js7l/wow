import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "popup" ]

  show() {
    console.log("hello")
    this.popupTarget.classList.remove('d-none')
  }

  close() {
    console.log(this.popupTarget)
    this.popupTarget.classList.add('d-none')
  }
}
