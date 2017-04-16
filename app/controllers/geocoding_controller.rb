require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    @clean_street_address = @street_address.downcase.tr(' ', '+')

    @url = "http://maps.googleapis.com/maps/api/geocode/json?address="+@clean_street_address

    @parsed_JSON_URL = JSON.parse(open(@url).read)

    @latitude =  @parsed_JSON_URL["results"][0]["geometry"]["location"]["lat"]

    @longitude = @parsed_JSON_URL ["results"][0]["geometry"]["location"]["lng"]

    render("geocoding/street_to_coords.html.erb")
  end
end
