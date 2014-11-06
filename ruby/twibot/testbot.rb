require 'twitter'
require 'pp'
client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "Jc13kcpuWLFJrflGkbXI4xCwH"
    config.consumer_secret     = "gsJhfFDSDhzGBfxbHL58V9MqOITWxX82Avj9WYp3u32FToxeLj"
    config.access_token        = "2879610956-eQP2JmDDSUJpjvHQdBSyspShQAWv2TA7cVZilpM"
    config.access_token_secret = "vErjJgJP8bCyGcbQi8XedmfDT4Zuhnc3sEhIbycTYDRj4"	
end
client.update("I'm tweeting")