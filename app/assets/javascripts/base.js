$(document).ready(function() {

  // disable interactive links
  $('.disabled-link').click(function(event) {
    event.preventDefault();
  });

  $(function() {
    $('#receipt_category').selectize({
      create: true,
      sortField: 'text'
    });
  });

}); //end of document ready