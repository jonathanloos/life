// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// Jquery
require('jquery')

// Bootstrap
import "bootstrap"
import 'bootstrap-daterangepicker';
console.log('here')
// Metafizzy
// https://packery.metafizzy.co/extras.html#browserify
var jQueryBridget = require('jquery-bridget');
var Isotope = require('isotope-layout');
jQueryBridget( 'isotope', Isotope, $ );

// Stimulus
import 'controllers'

Rails.start()
Turbolinks.start()
ActiveStorage.start()
