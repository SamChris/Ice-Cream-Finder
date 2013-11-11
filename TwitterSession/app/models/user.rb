require 'rest-client'
require 'addressable/uri'
require 'json'


class User < ActiveRecord::Base
  # attr_accessible :title, :body

  validates :twitter_user_id,
  validates :twitter_status_id,
  validates :screen_name,

  has_many (
  :statuses,
  class_name: 'statuses',
  foreign_key: :twitter_user_id
  primary_key: :id
  )


  def self.fetch_by_screen_name
    address = Addressable::Uri.new({scheme: 'https',
      host: 'api.twitter.com'
      path: '/1.1/statuses/user_timeline.json?'
      query: {self.screen_name.to_s}
      }).to_s

    http_object = TwitterSession.get(address)

    self.parse_twitter_params(http_object)

  end

  def self.parse_twitter_params(http_object)
    jsonified = http_object.body
    p_json = JSON.parse(jsonified)


    p_json.each_with_index do |per_tweet, i|
      User.create( p_json[i]["user"]["id_str"],
                   p_json[i]["id_str"],
                   p_json[i]["user"]["screen_name"] )
    end
  end


#TwitterSession.get("https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=TheEllenShow&count=2")




    #https://api.twitter.com/1.1/statuses/user_timeline.json


end
