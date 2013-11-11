require 'json'
require 'addressable/uri'
require 'rest-client'

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

    json_response2

end



def get_user_address
  #puts "Please give your current location"
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

   json_response_2 = get_nearby_ice_cream_places(lat, lng, the_key)

   locs = get_names_and_locations(json_response_2)

   json_directions = get_directions(lat, lng, locs)


   #create_output(json_directions)

end


def create_output(json_directions)
  json_directions.each do |directions|
   puts directions["routes"][0]["legs"][0]["steps"][0]["distance"]["text"]
   puts directions["routes"][0]["legs"][0]["steps"][0]["duration"]["text"]
   puts directions["routes"][0]["legs"][0]["steps"][0]["html_instructions"]
   p "\n\n\n\n\n\n\n"
 end
end

def get_names_and_locations(json)
  locs = []
  json["results"].each do |result|
    locs << result["vicinity"]
  end
  locs
end


def get_directions(lat, lng, locs)
  lat_lng = "#{lat},#{lng}"
  json_responses_3 =[]
  locs.each do |location|
    address_url3 = Addressable::URI.new(:scheme => 'https',
    :host => "maps.googleapis.com",
    :path => "/maps/api/directions/json",
    :query_values => {:origin => lat_lng,
                      :destination => location,
                      :mode => "walking",
                      :sensor => false
                     }).to_s
      response3 = RestClient.get(address_url3)
      json_responses_3 << JSON.parse(response3)
  end
  json_responses_3

end











