import { Controller } from 'stimulus'; 

export default class extends Controller {
  // ['target']
  static targets = ['grid'];

  // { ping: String }
  static values = {};

  initialize() { }

  connect() {
      console.log('isotope')
    $(this.gridTarget).isotope({
      // options
      itemSelector: '.grid-item',
      layoutMode: 'fitRows'
    });
  }
}