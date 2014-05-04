//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


function ready() {
    $('.content').popup();

    $('.ui.dropdown').dropdown({
        on: 'hover'
    });

    $('.ui.checkbox').checkbox();


    $('.ui.checkbox').checkbox();

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

    $(".sendBarcode").submit(function(e) {
        return false;
    });
}

/**
 * [createModules description]
 * @return {[type]} [description]
 */
function createModules() {

}

function openModal($element) {
    $($element).parent().find('.modal').modal('show');
    setTimeout(function() {
        console.log($($element).parent().find('.barcode-input'));
        $($element).parent().find('.modal').find('.barcode-input').val('ala');
    }, 1000);
}


$(document).ready(ready)
$(document).on('page:load', ready)