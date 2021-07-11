import { Controller } from 'stimulus'; 

export default class extends Controller {
  // ['target']
  static targets = ['grid'];

  // { ping: String }
  static values = {};

  initialize() { }

  connect() {
    $(document).on('reload.isotope.base', function(ev, target) {
      $('.grid').isotope({
        // options
        itemSelector: '.grid-item',
        layoutMode: 'masonry',
        masonry: {
          // use outer width of grid-sizer for columnWidth
          columnWidth: '.grid-item'
        }
      });
    });

    this.initIsotope();
  }

  initIsotope(){
    $(this.gridTarget).isotope({
      // options
      itemSelector: '.grid-item',
      layoutMode: 'masonry',
      masonry: {
        // use outer width of grid-sizer for columnWidth
        columnWidth: '.grid-item'
      }
    });
  }
}