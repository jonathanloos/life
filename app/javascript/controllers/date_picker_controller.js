import { Controller } from 'stimulus'; 

export default class extends Controller {
  static targets = ['daterange']
  static values = { options : String };

  initialize() {
    let date_formatting = {
      locale: {
        format: "YYYY-MM-DD",
      },
    };

    if(this.optionsValue.length > 0){
      $(this.daterangeTarget).daterangepicker({ ...JSON.parse(this.optionsValue), ...date_formatting});
    } else {
      $(this.daterangeTarget).daterangepicker(date_formatting);
    }
  }

  connect() {

  }
}