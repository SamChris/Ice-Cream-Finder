require 'singleton'
require 'launchy'
require 'oauth'
require 'yaml'

class TwitterSession

  attr_reader :access_token

  include Singleton

  CONSUMER_KEY = 'fjXB0WzPz5ZD6QJ2VaCYMg'
  CONSUMER_SECRET = 'i5Vt4AewTV9ohaXNgm3Pm22gCP9B4i13u3wLpte9w'
  CONSUMER = OAuth::Consumer.new(
     CONSUMER_KEY, CONSUMER_SECRET, site: "https://twitter.com")

  def initialize
    unless @access_token
      @access_token = authorize_user
    end
  end

  def self.get(*args)
    http_object = self.instance.access_token.get(*args)
    http_object
  end


  def self.post(*args)
    self.instance.access_token.post(*args)
  end

  def authorize_user
    # if File.exist?(token_file)
 #      File.open(token) {|f| YAML.load(f) }
 #    else
      access_token = request_access_token
      #File.open(token_file, "w") { |f| YAML.dump(access_token, f) }

      access_token
    # end

  end


  def request_access_token
    request_token = CONSUMER.get_request_token
    authorize_url = request_token.authorize_url
    puts "Go to this URL: #{authorize_url}"

    Launchy.open(authorize_url)

    puts "Login, and type your verification code in"
    oauth_verifier = gets.chomp

    access_token = request_token.get_access_token(
        :oauth_verifier => oauth_verifier
      )

    access_token
  end

end