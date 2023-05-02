/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

console.log('Hello World from Webpacker')

import '../stylesheets/application.scss';
import Rails from "@rails/ujs";
import './bootstrap';
Rails.start();

function observeMessageStateChanges() {
  console.log('jQuery version:', $.fn.jquery);

  const targetNode = $('.text-center').get(0);

  if (targetNode) {
    const observer = new MutationObserver(() => {
      location.reload();
    });

    observer.observe(targetNode, {
      childList: true,
      subtree: true,
      attributes: true,
    });
  } else {
    console.log("Element with .text-center not found");
  }
}

$(document).ready(() => {
  if (window.location.pathname.endsWith('/text_messages')) {
    observeMessageStateChanges();
  }
});


