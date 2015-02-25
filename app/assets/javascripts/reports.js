
// // Add new report form toggle
// $(document).ready(function() {
//   var toggled = false;

//   var buttonText = {
//     true: "Create a New Report",
//     false: "Hide Form"
//   };

//   $("#report-form").hide();
//   $("#new-report").on('click', function(){
//     toggled = !toggled;

//     var text = buttonText[!toggled];

//     $("#report-form").slideToggle(toggled);
//     $("#new-report").html(text)
//       .toggleClass("btn-primary", !toggled)
//       .toggleClass("btn-dark", toggled);
//   });
// }); //end of document ready


// // Add new receipt form toggle. in the report/show view 
// $(document).ready(function() {
//   var toggled = false;

//   var buttonText = {
//     true: "Add New Receipt",
//     false: "Hide Form"
//   };

//   $(".receipt-form-toggle").hide();
//   $("#new-receipt").on('click', function(){
//     toggled = !toggled;

//     var text = buttonText[!toggled];

//     $(".receipt-form-toggle").slideToggle(toggled);
//     $("#new-receipt").html(text)
//       .toggleClass("btn-primary", !toggled)
//       .toggleClass("btn-dark", toggled);
//   });
// }); //end of document ready


// // Drag and drop report sorting
// $(document).ready(function() {
//   $(function() {
//     $( "#sortable" ).sortable({
//       placeholder: "ui-state-highlight"
//     });
//     $( "#sortable" ).disableSelection();
//   });
// }); //end of document ready




