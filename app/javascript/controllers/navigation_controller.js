import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  scrollToTop() {
    console.log("scroll To TOP")
    window.scrollBy(0, -window.scrollY);
  };
}
