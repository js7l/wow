import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "view", "inputCategory", "inputDate", "inputTime", "inputLevel", "listButton", "calendarButton", "listView", "calendarView"]

  connect() {
    console.log("Hello from filter events.js")
  }

  updateView() {
    const listButtonActive = this.listButtonTarget.classList.contains("active")
    const calendarButtonActive = this.calendarButtonTarget.classList.contains("active")
    const url = `${this.formTarget.action}?query=${this.inputCategoryTarget.value}&date=${this.inputDateTarget.value}&time=${this.inputTimeTarget.value}&level=${this.inputLevelTarget.value}&list=${listButtonActive}&calendar=${calendarButtonActive}`
    console.log(url)

    fetch(url, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        this.viewTarget.outerHTML = data
      })

    // if (this.listButtonTarget.classList.contains("active")) {
    //   console.log("List")
    //   this.listViewTarget.classList.add("show", "active")
    //   this.calendarViewTarget.classList.remove("show", "active")
    // } else if (this.calendarButtonTarget.classList.contains("active")) {
    //   console.log("Calendar")
    //   this.calendarViewTarget.classList.add("show", "active")
    //   this.listViewTarget.classList.remove("show", "active")
    //   console.log(this.calendarViewTarget.classList)
    //   console.log(this.listViewTarget.classList)
    // }
    }
}
