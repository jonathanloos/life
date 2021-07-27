import { Controller } from 'stimulus'; 

export default class extends Controller {
  static targets = ['daterange']
  static values = { options : String };

  initialize() {

    if(this.optionsValue.length > 0){
      $(this.daterangeTarget).daterangepicker(JSON.parse(this.optionsValue));
    } else {
      $(this.daterangeTarget).daterangepicker();
    }
  }

  connect() {

  }
}