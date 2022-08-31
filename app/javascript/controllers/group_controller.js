import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "count"]
  connect() {
  }
  form_load(){
    event.preventDefault();
    event.stopPropagation();

    const [, , xhr] = event.detail;
    // debugger
    document.getElementById("modal-title").innerHTML = this.element.dataset.title;
    document.getElementById("modal-body").innerHTML = xhr.responseText;
    document.getElementById("modal").className = "modal show";
  }
}
