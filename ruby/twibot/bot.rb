require 'yaml'
require 'twitter'
require 'tweetstream'
 
class Bot
  attr_accessor :client, :timeline
  
  def initialize()
    keys = YAML.load_file('./config.yml')
    @name = keys["my_id"]
 
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = keys["api_key"]
      config.consumer_secret     = keys["api_secret"]
      config.access_token        = keys["access_token"]
      config.access_token_secret = keys["access_token_secret"]
    end
 
    TweetStream.configure do |config|
      config.consumer_key       = keys["api_key"]
      config.consumer_secret    = keys["api_secret"]
      config.oauth_token        = keys["access_token"]
      config.oauth_token_secret = keys["access_token_secret"]
      config.auth_method        = :oauth
    end
 
    @timeline = TweetStream::Client.new

  end
  def name()
    @name
  end

  def post(text = "",twitter_id,status_id)
      if status_id != nil
        rep_text = "@#{twitter_id} #{text}"
        @client.update(rep_text,{:in_reply_to_status_id => status_id})
        puts "#{rep_text}"
      else
        @client.update(text)
        puts "#{text}"
      end
  end
  def post_pic(text = "",media,twitter_id,status_id)
    if status_id != nil
        rep_text = "@#{twitter_id} #{text}"
        @client.update_with_media(rep_text,File.open(media),{:in_reply_to_status_id => status_id})
        puts "#{rep_text}"
      else
        @client.update_with_media(text,File.open(media))
        puts "#{text}"
      end
  end
 
  def fav(status_id)
    if status_id != nil
      @client.favorite(status_id)
    end
  end
 
  def retweet(status_id)
    if status_id != nil
      @client.retweet(status_id)
    end
  end

  def favopen(user)
    if user != nil
      puts @client.home_timeline()
    end
  end

end