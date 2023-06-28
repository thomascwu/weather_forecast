require 'test_helper'

# Test case for the service to make the API call and return the weather forecase details based on the geocodes of the input address
class WeatherForecastServiceTest < ActiveSupport::TestCase

  test "call with known parameters" do
    # Example address is 2948 Logbridge Rd, High Point, North Carolina
    latitude = 36.0432959
    longitude = -79.9975273 
    weather_forecast = WeatherForecastService.call(latitude, longitude)
    assert_includes -4..44, weather_forecast.temperature
    assert_includes -4..44, weather_forecast.temperature_min
    assert_includes -4..44, weather_forecast.temperature_max
    assert_includes 0..100, weather_forecast.humidity
    assert_includes 900..1100, weather_forecast.pressure
    refute_empty weather_forecast.description
  end

end
