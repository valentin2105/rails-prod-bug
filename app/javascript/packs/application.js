// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//= require jquery_ujs

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

//require("packs/table-sort.js")
//require("packs/google-charts.js")

import toastr from "toastr";

toastr.options = {
    toastClass: 'alert',
    iconClasses: {
        error: 'alert-danger',
        info: 'alert-info',
        success: 'alert-success',
        warning: 'alert-warning'
    }
};


import "bootstrap"
import "../stylesheets/application"
import $ from 'jquery';

// easeInOutExpo Declaration
$.extend($.easing, {
    easeInOutExpo: function (x, t, b, c, d) {
        if (t === 0) {
            return b;
        }
        if (t === d) {
            return b + c;
        }
        if ((t /= d / 2) < 1) {
            return c / 2 * Math.pow(2, 10 * (t - 1)) + b;
        }
        return c / 2 * (-Math.pow(2, -10 * --t) + 2) + b;
    }
});

// Preloader js    
// $(window).on('load', function () {
//     $('.preloader').fadeOut(700);
// });


function showPopupMessage(){
    $('[data-popup-message]').each((ind, el) => {                 
        toastr[el.dataset.type](el.dataset.message, '', {"closeButton": false, "debug": false, "positionClass": "toast-top-full-width", "onclick": null, "showDuration": "300", "hideDuration": "1000", "timeOut": "5000", "extendedTimeOut": "1000", "showEasing": "swing", "hideEasing": "linear", "showMethod": "fadeIn", "hideMethod": "fadeOut" });
        el.remove();
    });

}

// on ruby "interaction" 
document.addEventListener("turbolinks:load", () => {
    // chercher un élément ayant un attribut 'data-popup-message' et afficher
    // un pessage en utilisant le type depuis l'attribut "data-type" et le message depuis l'attribut 'data-message'
    showPopupMessage();

    // back to top button
    $('.back-to-top').on('click', function (e) {
        e.preventDefault();
        $('html,body').animate({
            scrollTop: 0
        }, 1500, 'easeInOutExpo');
    });

})

// on page load 
$(function () {

    // chercher un élément ayant un attribut 'data-popup-message' et afficher
    // un pessage en utilisant le type depuis l'attribut "data-type" et le message depuis l'attribut 'data-message'
    showPopupMessage();
  
    // back to top button
    $('.back-to-top').on('click', function (e) {
        e.preventDefault();
        $('html,body').animate({
            scrollTop: 0
        }, 1500, 'easeInOutExpo');
    });
});

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)




