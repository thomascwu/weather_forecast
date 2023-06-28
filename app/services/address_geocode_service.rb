=begin

  Steps to make the successful this AddressGeocodeService call:

  1. Geocoder gem is used to access the ArcGIS API using the real ArcGIS API credentials to convert address to corresponding geocodes

  2. How to set up the real ArcGIS API credentials in the app:
  
    1. You need to sign up to get your real ArcGIS API credentials here: https://developers.arcgis.com/sign-up/

    2. Set your real ArcGIS API credentials in the Rails credentials object:

        Edit Rails credentials: 

          EDITOR="code --wait"  bin/rails credentials:edit

        Your real ArcGIS API credentials should look like this:

          arcgis_api_user_id: <your user id used to sign up>

          arcgis_api_secret_key: <your ArcGIS API secret key that assigned to you after sign up>

    3. Add your real ArcGIS API credentials in the app at config/initializers/geocoder.rb:

        Geocoder.configure(
          esri: {
              api_key: [
                  Rails.application.credentials.arcgis_api_user_id, # <your user id used to sign up>
                  Rails.application.credentials.arcgis_api_secret_key, # <your ArcGIS API secret key that assigned to you after sign up>
              ], 
              for_storage: true
          }
      )

=end

# Service class to convert the input address to its corresponding geocodes for the subsequent weather forecast API call
class AddressGeocodeService 

  def self.call(address)
    # call the Geocoder service with the input address and return the corresponding geocodes
    response = Geocoder.search(address)

    # response validations to ensure the data validity
    response or raise IOError.new "Geocoder error"
    response.length > 0 or raise IOError.new "Geocoder is empty: #{response}"

    # validate the geo data and return corresponding error messages if any
    data = response.first.data
    data or raise IOError.new "Geocoder data error"
    data["lat"] or raise IOError.new "Geocoder latitude is missing"
    data["lon"] or raise IOError.new "Geocoder longitude is missing"
    data["address"] or raise IOError.new "Geocoder address is missing" 
    data["address"]["postcode"] or raise IOError.new "Geocoder postal code is missing"

    # store the geo data into the address_geocode object and return back to the caller
    address_geocode = OpenStruct.new
    address_geocode.latitude = data["lat"].to_f
    address_geocode.longitude = data["lon"].to_f
    address_geocode.postal_code = data["address"]["postcode"]
    address_geocode
  end

end
