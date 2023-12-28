import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="project-items--form"
export default class extends Controller {
  static targets = ["supplierInput"]

  supplierChanged(e){
    if (e.target.selectedOptions[0].label == 'Other'){
      this.supplierInputTarget.classList.remove('hidden')
    } else {
      this.supplierInputTarget.classList.add('hidden')
    }
  }
}
