  reportEditor = {
    initialize: function(reportId) {
      // Edit the report form
      $(document).ready(function() {
        var toggled = false;

        var buttonText = {
          true: "Edit",
          false: "Hide Form"
        };

        $("#edit_report_" + reportId).hide();
        $("#report_" + reportId).on('click', function(){
          toggled = !toggled;

          var text = buttonText[!toggled];

          $("#edit_report_" + reportId).slideToggle(toggled);
          $(this).html(text)
            .toggleClass("btn-primary", !toggled)
            .toggleClass("btn-dark", toggled);
        });
      }); //end of document ready
    }
  }


// // Drag and drop report sorting
// $(document).ready(function() {
//   $(function() {
//     $( "#sortable" ).sortable({
//       placeholder: "ui-state-highlight"
//     });
//     $( "#sortable" ).disableSelection();
//   });
// }); //end of document ready




