require 'singleton'
require 'launchy'
require 'oauth'

class TwitterSession

  attr_reader :access_token

  include Singleton

  CONSUMER_KEY
  CONSUMER_SECRET


  def initialize
    unless @access_token
      @access_token = authorize_user
    end
  end

  def self.get(*args)
    self.instance.access_token.get(*args)
  end


  def self.post(*args)
    self.instance.access_token.post(*args)
  end

  protected
    def authorize_user
      puts "Enter access token"
      access_token = gets.chomp

      access_token
    end

end