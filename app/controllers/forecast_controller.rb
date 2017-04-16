require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    @lat_lng = @lat.to_s+","+@lng.to_s

    @url2 = "https://api.darksky.net/forecast/eeaf82d4a2d8d5561104637cff579f40/"+@lat_lng

    @parsed_darksky_URL = JSON.parse(open(@url2).read)

    @current_temperature = @parsed_darksky_URL["currently"]["temperature"]

    @current_summary = @parsed_darksky_URL["currently"]["summary"]

    @summary_of_next_sixty_minutes = @parsed_darksky_URL["minutely"]["summary"]

    @summary_of_next_several_hours = @parsed_darksky_URL["hourly"]["summary"]

    @summary_of_next_several_days = @parsed_darksky_URL["daily"]["summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end


##Personal Key: eeaf82d4a2d8d5561104637cff579f40 ##
