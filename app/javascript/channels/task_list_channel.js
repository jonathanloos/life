import consumer from "./consumer"

consumer.subscriptions.create("TaskListChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("disconnected");
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    $('#task_list_index').replaceWith(this._parseHTMLResponse(data.body.html));
    $.fn.dispatchCustomEvent('reload.isotope.base');
    console.log('here')
    window.notifier.success(data.message)
  },

  // From: https://stackoverflow.com/a/42658543/445724
  // using .innerHTML= is risky. Instead we need to convert the HTML received
  // into elements, then append them.
  // It's wrapped in a <template> tag to avoid invalid (e.g. a block starting with <tr>)
  // being mutated inappropriately.
  _parseHTMLResponse(responseHTML){
    let parser = new DOMParser();
    let responseDocument = parser.parseFromString( `<template>${responseHTML}</template>` , 'text/html');
    let parsedHTML = responseDocument.head.firstElementChild.content;
    return parsedHTML;
  }
});
