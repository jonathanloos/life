import { Controller } from 'stimulus'; 

var frequency = 200;
var drawDebouncedEvent = _.debounce(function(element){
    console.log($(element).closest("form")[0])
    Rails.fire($(element).closest("form")[0], 'submit');

}, frequency*4, {leading:false, trailing:true});

export default class extends Controller {
  // ['target']
  static targets = [];

  // { ping: String }
  static values = {};

  initialize() { }

  connect() {
      $(this.element).on('change keyup', () => {
        console.log('leggo')
        drawDebouncedEvent(this.element);
        
      });
  }
}