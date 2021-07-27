import { Controller } from 'stimulus'; 

export default class extends Controller {
  // ['target']
  static targets = [];

  // { ping: String }
  static values = { options: Object };

  initialize() { }

  connect() {
    console.log("hello from StimulusJS")
    $(this.element).datepicker(this.optionsValue);
  }
}