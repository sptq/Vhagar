// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


function ready() {
    $('.ui.dropdown').dropdown({
        on: 'hover'
    });

    $('.ui.checkbox')
        .checkbox();

    $('.ui.form').form(validationRules, {
        on: 'blur'
    });

    $('.ui.checkbox')
        .checkbox();

    $('.ui.form')
        .form(validationRules, {
            on: 'blur'
        });


    $('.masthead .information').transition('scale in');

    $('.message .close').on('click', function() {
        $(this).closest('.message').fadeOut();
    });

    $('.withPopup').popup({
        on: 'click',
        title: 'Uzupełnij profil',
        content: 'Aby wykonać tą akcję musisz najpierw uzupełnić swój profil.',
        variation: 'inverted'
    });

    $('.item')
        .popup({
            on: 'focus'
        });
}

/**
 * [createModules description]
 * @return {[type]} [description]
 */
function createModules() {

}

$(document).ready(ready)
$(document).on('page:load', ready)