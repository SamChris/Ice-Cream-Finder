class Status < ActiveRecord::Base

  validates :body, presence: true
  validates :twitter_user_id, presence: true

  belongs_to (
  :user,
  class_name: 'user',
  foreign_key: :twitter_user_id
  primary_key: :id
  )
  # attr_accessible :title, :body

  def self.parse_twitter_params(http_object)
    jsonified = http_object.body
    p_json = JSON.parse(jsonified)


    p_json.each_with_index do |per_tweet, i|
      Status.create( p_json[i]["id_str"],
                   p_json[i]["text"] )
    end
  end

end
