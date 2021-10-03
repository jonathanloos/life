import { Controller } from 'stimulus'; 
let debounce = require('lodash/debounce');

var frequency = 300;

export default class extends Controller {
  // ['target']
  static targets = [];

  // { ping: String }
  static values = {};

  initialize() {
    // Debounce the submit.
    this.submit = debounce(this.submit, frequency*4, {leading:false, trailing:true}).bind(this)
  }

  connect() {
    $(this.element).on('change keyup', () => {
      this.submit();
    });
  }

  submit(){
    Rails.fire($(this.element).closest("form")[0], 'submit');
  }
}