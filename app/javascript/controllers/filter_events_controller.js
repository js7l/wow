import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
<<<<<<< HEAD
  static targets = ["form", "list", "inputCategory", "inputDate", "inputTime", "inputLevel"]
=======
  static targets = ["form", "view", "inputCategory", "inputDate", "inputTime", "inputLevel", "listButton", "calendarButton", "listView", "calendarView"]
>>>>>>> c1395a4ca8f248c19c9fb0c168220d978f6d3ab6

  connect() {
    console.log("Hello from filter events.js")
  }

<<<<<<< HEAD
  updateList() {
    const url = `${this.formTarget.action}?query=${this.inputCategoryTarget.value}&date=${this.inputDateTarget.value}&time=${this.inputTimeTarget.value}&level=${this.inputLevelTarget.value}`
=======
  updateView() {
    const listButtonActive = this.listButtonTarget.classList.contains("active")
    const calendarButtonActive = this.calendarButtonTarget.classList.contains("active")
    const url = `${this.formTarget.action}?query=${this.inputCategoryTarget.value}&date=${this.inputDateTarget.value}&time=${this.inputTimeTarget.value}&level=${this.inputLevelTarget.value}&list=${listButtonActive}&calendar=${calendarButtonActive}`
    console.log(url)
>>>>>>> c1395a4ca8f248c19c9fb0c168220d978f6d3ab6

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
