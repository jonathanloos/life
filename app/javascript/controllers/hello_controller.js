import { Controller } from 'stimulus'; 

export default class extends Controller {
  // ['target']
  static targets = [];

  // { ping: String }
  static values = {};

  initialize() { }

  connect() {
    console.log("hello from StimulusJS")
  }
}