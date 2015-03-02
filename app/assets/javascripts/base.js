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

$(document).ready(function() {
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