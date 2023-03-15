import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-listing"
export default class extends Controller {
  static targets = ['next'];

  
  connect() {
    console.log("hi")
    console.log(this.openUserMenuTarget);
    this.nextTarget.addEventListener('click', this.nextStep.bind(this))
  }

  nextStep() {
    const item = document.getElementById('first-form');
    item.classList.toggle('hidden');
  }
}
