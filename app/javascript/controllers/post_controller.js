import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "post_form"]
  connect() {
  }
  form_load(){
    event.preventDefault();
    event.stopPropagation();

    const [, , xhr] = event.detail;
    // debugger
    // this.element.display = none;
    document.getElementById("form_post_"+this.element.dataset.cid).innerHTML = xhr.responseText;
  }
}
