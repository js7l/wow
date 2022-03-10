import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "input"]

  connect() {
    console.log("Hello from filter events.js")
  }

  dropdown(event) {
    console.log(this.inputTarget.value)
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    fetch(url, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data
      })
  }
}
