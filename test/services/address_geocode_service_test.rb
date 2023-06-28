require 'test_helper'

# Test case for the service to convert the input address to its corresponding geocodes
class AddressGeocodeService < ActiveSupport::TestCase

  test "call with known address" do
    address = "2948 Logbridge Rd, High Point, North Carolina"
    address_geocode = AddressGeocodeService.call(address)
    assert_in_delta 36.04, address_geocode.latitude, 0.1
    assert_in_delta -79.99, address_geocode.longitude, 0.1
    assert_equal "27265", address_geocode.postal_code
  end

end
