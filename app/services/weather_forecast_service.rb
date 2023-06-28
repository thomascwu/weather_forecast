# Service class to make the API call to return the weather forecase details based on the geocodes of the input address
class WeatherForecastService
    
  def self.call(latitude, longitude)
    # make the connection to the API endpoints
    conn = Faraday.new("https://api.openweathermap.org") do |f|
      f.request :json # encode req bodies as JSON and automatically set the Content-Type header
      f.request :retry # retry transient failures
      f.response :json # decode response bodies as JSON
    end

    # get the response data from the API call based on the valid credentials
    response = conn.get('/data/2.5/weather', {
      appid: Rails.application.credentials.openweather_api_key,
      lat: latitude,
      lon: longitude,
      units: "metric",
    })

    # response validations to ensure the data validity
    body = response.body
    body or raise IOError.new "OpenWeather response body failed"

    # parse the response data and return corresponding error messages if any
    body["main"] or raise IOError.new "OpenWeather main section is missing"
    body["main"]["temp"] or raise IOError.new "OpenWeather temperature is missing"
    body["main"]["temp_min"] or raise IOError.new "OpenWeather temperature minimum is missing"
    body["main"]["temp_max"] or raise IOError.new "OpenWeather temperature maximum is missing"
    body["weather"] or raise IOError.new "OpenWeather weather section is missing"
    body["weather"].length > 0 or raise IOError.new "OpenWeather weather section is empty"
    body["weather"][0]["description"] or raise IOError.new "OpenWeather weather description is missing"

    # store the response data into the weather_forecast object and return back to the caller
    weather_forecast = OpenStruct.new
    weather_forecast.temperature = body["main"]["temp"]
    weather_forecast.temperature_min = body["main"]["temp_min"]
    weather_forecast.temperature_max = body["main"]["temp_max"]
    weather_forecast.humidity = body["main"]["humidity"]
    weather_forecast.pressure = body["main"]["pressure"]
    weather_forecast.description = body["weather"][0]["description"]
    weather_forecast
  end
    
end
