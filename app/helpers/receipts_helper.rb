module ReceiptsHelper

  def generate_markers(locations)
    Gmaps4rails.build_markers(locations) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      # link = link_to location.title, campaign_path(location)
      # desc = location.description.truncate(50)
      marker.infowindow "<h4>#{location.business_name}</h4>"
    end.to_json
  end

end
