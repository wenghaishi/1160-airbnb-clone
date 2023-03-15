import { Controller } from "@hotwired/stimulus"
import { toggle } from 'el-transition'

export default class extends Controller {
  static targets = ['openUserMenu'];

  connect() {
    console.log("hi")
    console.log(this.openUserMenuTarget);
    this.openUserMenuTarget.addEventListener('click', this.toggleDropdownMenu)
  }

  toggleDropdownMenu() {
    toggle(document.getElementById('menu-dropdown-items'));
  }
}
