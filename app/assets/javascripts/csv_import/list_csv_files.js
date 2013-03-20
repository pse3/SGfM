$(document).ready(function() {
    $('.delete').on('ajax:success', function(data, status, xhr) {
        $(this).parent().parent().remove();
    });
});