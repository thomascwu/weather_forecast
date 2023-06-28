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
