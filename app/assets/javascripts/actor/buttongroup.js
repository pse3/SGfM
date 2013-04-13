//Helps to transfer the "state" of a radiobuttons-like button-group to a hidden input field (so it can be POSTed)
$(document).ready(function() {
  $('div.btn-group[data-toggle-name]').each(function () {
    var group = $(this);
    var form = group.parents('form').eq(0);
    var name = group.attr('data-toggle-name');
    var hidden = $('input[name="' + name + '"]', form);
    $('button', group).each(function () {
      $(this).on('click', function () {
        hidden.val($(this).val());
      });
    });
  });
});