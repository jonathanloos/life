import { Controller } from 'stimulus'; 

export default class extends Controller {
  static targets = ['daterange']

  initialize() {
    console.log($(this.daterangeTarget))
    $(this.daterangeTarget).daterangepicker();
  }

  connect() {

  }
}