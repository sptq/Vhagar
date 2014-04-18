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

$(document)
    .ready(function() {

        var
        changeSides = function() {
            $('.ui.shape')
                .eq(0)
                .shape('flip over')
                .end()
                .eq(1)
                .shape('flip over')
                .end()
                .eq(2)
                .shape('flip back')
                .end()
                .eq(3)
                .shape('flip back')
                .end();
        },
            validationRules = {
                firstName: {
                    identifier: 'email',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter an e-mail'
                    }, {
                        type: 'email',
                        prompt: 'Please enter a valid e-mail'
                    }]
                }
            };

        $('.ui.dropdown')
            .dropdown({
                on: 'hover'
            });

        $('.ui.checkbox')
            .checkbox();

        $('.ui.form')
            .form(validationRules, {
                on: 'blur'
            });

        $('.masthead .information')
            .transition('scale in');

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
    });