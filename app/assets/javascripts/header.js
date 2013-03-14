
$(function() {
  // Setup drop down menu
  $('.dropdown-toggle').dropdown();

  // Fix input element click problem
  $('.dropdown input, .dropdown label').click(function(e) {
    e.stopPropagation();
  });
});

$('#anchor-around-header-arrow').click(
  function(obj){
    if ($('#header-arrow').hasClass('icon-chevron-up')) {
      $('#header-arrow').removeClass('icon-chevron-up');
      $('#header-arrow').addClass('icon-chevron-down');
    } else {
      $('#header-arrow').removeClass('icon-chevron-down');
      $('#header-arrow').addClass('icon-chevron-up');
    }
  });