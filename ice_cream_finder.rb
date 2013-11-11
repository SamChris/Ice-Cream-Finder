require 'json'
require 'addressable/uri'
require 'rest-client'

def get_current_location


end

def get_nearby_ice_cream_places
end

def get_lat_lng(address)
end

def get_user_address
  puts "Please give your current location"
  address_string = "1600 Amphitheatre Parkway, Mountain View, CA"
  address_url = Addressable::URI.new(:scheme => "https",
   :host => "maps.googleapis.com",
   :path => "/maps/api/geocode/json",
   :query_values => {:address => address_string,
         :sensor => false}
   ).to_s

   response = RestClient.get(address_url)
   json_response = JSON.parse(response)

   coordinates = (json_response["results"][0]["geometry"]["location"])

   lat, lng = coordinates["lat"], coordinates["lng"]


end















