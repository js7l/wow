import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "list", "inputCategory", "inputDate", "inputTime", "inputLevel"]

  connect() {
    console.log("Hello from filter events.js")
  }

  updateList() {
    const url = `${this.formTarget.action}?query=${this.inputCategoryTarget.value}&date=${this.inputDateTarget.value}&time=${this.inputTimeTarget.value}&level=${this.inputLevelTarget.value}`

    fetch(url, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data
      })
  }
}
