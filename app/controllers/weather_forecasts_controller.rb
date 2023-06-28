# Controller to return the weather forecast data based on the address which will be cached based on the zip codes
class WeatherForecastsController < ApplicationController

  def show
    @address_default = "2948 Logbridge Rd, High Point, North Carolina"
    # use session to store the input address
    session[:address] = params[:address]
    if params[:address]
      begin
        @address = params[:address]
        # convert the input address to the corresponding geocodes for the subsequent weather forecase API call
        @address_geocode = AddressGeocodeService.call(@address)

        # cache the input address based on the zip code
        @weather_forecast_cache_key = "#{@address_geocode.postal_code}"

        # retrieve from the cache if already exists
        @weather_forecast_cache_exist = Rails.cache.exist?(@weather_forecast_cache_key)

        # make the weather forecase API call and return the forecase details back to the UI view and cache the forecase details for 30 minutes
        @weather_forecast = Rails.cache.fetch(@weather_forecast_cache_key, expires_in: 30.minutes) do
          WeatherForecastService.call(@address_geocode.latitude, @address_geocode.longitude)          
      end
      # display the error(s) if any with the flash alerts on the UI view
      rescue => e
        flash.alert = e.message
      end
    end
  end

end
