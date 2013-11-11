require 'json'
require 'addressable/uri'
require 'rest-client'

def get_directions


end

def get_nearby_ice_cream_places(lat, lng, the_key)
  location_string = "#{lat},#{lng}"
  address_url2 = Addressable::URI.new(:scheme => 'https',
  :host => "maps.googleapis.com",
  :path => "/maps/api/place/nearbysearch/json",
  :query_values => {:key => the_key,
                    :location => location_string,
                    :radius => 1608,
                    :sensor => false,
                    :keyword => "icecream"}
    ).to_s
    response2 = RestClient.get(address_url2)
    json_response2 = JSON.parse(response2)

    json_response


end


def get_lat_lng(address)
end

def get_user_address
  puts "Please give your current location"
  address_string = "702 Broadway, New York, NY 10002"
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

   the_key = "AIzaSyANbDooUPKG_ySNR5RsOBBbQ1J0bovorC8"

   json_response_2 = get_nearby_ice_cream_places(lat, lon, the_key)

   names_and_locs = get_names_and_locations(json_response_2)

   get_directions(lat, lng, json_response_2)
end

def get_names_and_locations(json)
  names_and_locs = {}














