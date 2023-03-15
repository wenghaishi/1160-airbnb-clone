import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-listing"
export default class extends Controller {
  static targets = ["next", "next1"];

  
  connect() {
    console.log("hi")
    console.log(this.openUserMenuTarget);
    this.nextTarget.addEventListener('click', this.nextStep.bind(this))
    this.next1Target.addEventListener('click', this.lastStep.bind(this))
  }

  nextStep() {
    const firstItem = document.getElementById('first-form');
    const secondItem = document.getElementById('second-form');
    const firstFooter = document.getElementById('firstFooter');
    const secondFooter = document.getElementById('secondFooter');
    firstFooter.classList.toggle('hidden');
    secondFooter.classList.toggle('hidden');
    firstItem.classList.toggle('hidden');
    secondItem.classList.toggle('hidden');
  }

  lastStep() {
    const lastItem = document.getElementById('last-form');
    const secondItem = document.getElementById('second-form');
    lastItem.classList.remove('hidden');
    secondItem.classList.toggle('hidden');
  }
}
