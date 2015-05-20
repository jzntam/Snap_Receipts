$(document).ready(function() {

  // Sidebar Action
  $("#menu-close").click(function(e) {
    e.preventDefault();
    $("#sidebar-wrapper").toggleClass("active");
  });

  $("#menu-toggle").click(function(e) {
    e.preventDefault();
    $("#sidebar-wrapper").toggleClass("active");
  });

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

//Landing Page JS
$(document).ready(function() {

  // Scroll Animation on landing page
  $(function() {
    $('a[href*=#]:not([href=#])').click(function() {
      if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') || location.hostname == this.hostname) {

        var target = $(this.hash);
        target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
        if (target.length) {
          $('html,body').animate({
            scrollTop: target.offset().top
          }, 1000);
          return false;
        }
      }
    });
  });

  // Organize Receipts toggle
  var toggled = false;
  $("#org_rec_more").hide();
  $("#org_rec").on('click', function(){
    toggled = !toggled;
    $("#org_rec_more").slideToggle(toggled);
    $("#org_rec").html()
      .toggleClass("btn-light", !toggled)
      .toggleClass("btn-dark", toggled);
  });

  // Take Pic toggle
  var toggled = false;
  $("#take_pic_more").hide();
  $("#take_pic").on('click', function(){
    toggled = !toggled;
    $("#take_pic_more").slideToggle(toggled);
    $("#take_pic").html()
      .toggleClass("btn-light", !toggled)
      .toggleClass("btn-dark", toggled);
  });

  // Scan image toggle
  $("#scan_img_more").hide();
  $("#scan_img").on('click', function(){
    toggled = !toggled;
    $("#scan_img_more").slideToggle(toggled);
    $("#scan_img").html()
      .toggleClass("btn-light", !toggled)
      .toggleClass("btn-dark", toggled);
  });

  // Database toggle
  $("#db_cloud_more").hide();
  $("#db_cloud").on('click', function(){
    toggled = !toggled;
    $("#db_cloud_more").slideToggle(toggled);
    $("#db_cloud").html()
      .toggleClass("btn-light", !toggled)
      .toggleClass("btn-dark", toggled);
  });

}); //end of document ready

//JS for Reports
$(document).ready(function() {
  //Drag and Drop Report Sorting
  $('#all_reports').sortable({
    update: function() {
      var ids = $(this).sortable('serialize');
      $.post('/reports/sort', ids);
    }
  });

  // Add new report form toggle
  var toggled = false;

  var buttonText = {
    true: "Create a New Report",
    false: "Hide Form"
  };

  $("#report-form").hide();
  $("#new-report").on('click', function(){
    toggled = !toggled;

    var text = buttonText[!toggled];

    $("#report-form").slideToggle(toggled);
    $("#new-report").html(text)
      .toggleClass("btn-primary", !toggled)
      .toggleClass("btn-dark", toggled);
  });

}); //end of document ready


// Receipt JS
$(document).ready(function() {
  // adding form control to dropdown and edit receipt form
  $(".edit_receipt input#receipt_sub_total").addClass('form-control').css('width', "190px")
  $(".edit_receipt select#receipt_category").addClass('form-control');
  $(".edit_receipt select#receipt_tax_type").addClass('form-control');
  $(".edit_receipt input#receipt_tax_total").addClass('form-control');
  $(".edit_receipt select#receipt_tax_type").css('width', "150px").css('display', 'inline-block');
  $(".edit_receipt input#receipt_tax_total").css('width', "190px").css('display', 'inline-block');
  $(".edit_receipt input#receipt_total").addClass('form-control').css('width', "190px")
}); //end of document ready