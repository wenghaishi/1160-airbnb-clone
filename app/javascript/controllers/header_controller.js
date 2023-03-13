import { Controller } from "@hotwired/stimulus"
import { toggle } from 'el-transition'

export default class extends Controller {
  static targets = ['openUserMenu'];

  connect() {
    console.log(this.openUserMenuTarget);
    this.openUserMenuTarget.addEventListener('click', this.toggleDropdownMenu)
    console.log("hi")
  }

  toggleDropdownMenu() {
    toggle(document.getElementById('menu-dropdown-items'));
    console.log("hi")
  }
}

// import { Controller } from "@hotwired/stimulus"

// // Connects to data-controller="header"
// export default class extends Controller {
//   connect() {
//   }
// }

