import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "view", "inputCategory", "inputDate", "inputTime", "inputLevel", "listButton", "calendarButton", "listView", "calendarView", "tabs"]

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

    }

    swichTab(event) {
      if(event.currentTarget == this.calendarButtonTarget) {
        this.tabsTarget.classList.add('slide')
        this.listButtonTarget.classList.remove("slide", "active")
        this.calendarButtonTarget.classList.add('active')
        this.calendarViewTarget.classList.remove('d-none')
        this.listViewTarget.classList.add('d-none')
      } else {
        this.calendarButtonTarget.classList.remove("slide", "active")
        this.tabsTarget.classList.remove('slide')
        event.currentTarget.classList.add('active')
        this.calendarViewTarget.classList.add('d-none')
        this.listViewTarget.classList.remove('d-none')
      }
    }
}
