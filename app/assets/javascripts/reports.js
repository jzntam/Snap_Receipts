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


var mappyMaps = function(){
  initialize: function(longitude, latitude, business_name) {
    $(document).ready(function(){
      handler = Gmaps.build('Google');
      handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        markers = handler.addMarkers([
          {
            "lat": latitude,
            "lng": longitude,
            "infowindow": "business_name"
          }
        ]);
        handler.bounds.extendWith(markers);
        handler.fitMapToBounds();
        handler.getMap().setZoom(13);
      });
    })
  };
};


