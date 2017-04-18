require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    @clean_street_address = @street_address.tr(' ', '+')

    @url = "http://maps.googleapis.com/maps/api/geocode/json?address="+@clean_street_address

    @parsed_JSON_URL = JSON.parse(open(@url).read)

    @lat =  @parsed_JSON_URL["results"][0]["geometry"]["location"]["lat"]

    @lng = @parsed_JSON_URL ["results"][0]["geometry"]["location"]["lng"]

    @lat_lng = @lat.to_s+","+@lng.to_s

    @url2 = "https://api.darksky.net/forecast/eeaf82d4a2d8d5561104637cff579f40/"+@lat_lng

    @parsed_darksky_URL = JSON.parse(open(@url2).read)

    @current_temperature = @parsed_darksky_URL["currently"]["temperature"]

    @current_summary = @parsed_darksky_URL["currently"]["summary"]

    @summary_of_next_sixty_minutes = @parsed_darksky_URL["minutely"]["summary"]

    @summary_of_next_several_hours = @parsed_darksky_URL["hourly"]["summary"]

    @summary_of_next_several_days = @parsed_darksky_URL["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
