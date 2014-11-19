# coding:utf-8

require './bot.rb'
require './BF.rb'
require "MeCab"

bot = Bot.new
mecab = MeCab::Tagger.new()


begin
  bot.timeline.userstream do |status|
 
    twitter_id = status.user.screen_name
    name       = status.user.name
    contents   = status.text
    status_id  = status.id
 
    # except RT
    if !contents.index("RT")
      str_time = Time.now.strftime("[%Y-%m-%d %H:%M]")
 
      # except REPLY TO OTHERS + REACTION TIMELINE
      # =~ jedge match
      if !(/^@\w*/.match(contents))

        puts contents+"\n"
        node = mecab.parseToNode(contents)
        while node do
          surface = node.surface
          surface.force_encoding('UTF-8')
          feature = node.feature.force_encoding('UTF-8')
          part_of_speech = feature.split(',')[0]
          if part_of_speech == "名詞"
            puts sprintf("%s\t[%s]", surface, part_of_speech)
            File.open("word.txt","a") do |file|
              file.write(surface+"\n")
            end
          end
          node = node.next
        end

        if contents =~ /みやび/
          puts "m\n"
          bot.fav(status_id)
        end
        if contents =~ /まーぼう/
          puts "c\n"
          text = "なんだそのおち\n#{str_time}"
          bot.post(text,twitter_id,status_id)
        end
        if contents =~ /にゃんこ/
          puts "n\n"
          bot.fav(status_id)
        end
      end
 
      # REPLY TO ME
      if contents =~ /^@miyabinobot\s*/
        bot.post("reply"+str_time,nil,nil)
        if contents =~/ほげ/
          text = "はい\n #{str_time}"
          bot.fav(status_id)
          bot.post(text,twitter_id,status_id)
        elsif contents =~/^@miyabinobot\sBF\s/
          text = contents.tr("@miyabinobot\sBF\s","")
          text = BF(text)
          bot.post(text,twitter_id,status_id)
        end
      end
 
    end
  sleep 2
  end
rescue => em
  puts Time.now
  p em
  sleep 2
  retry
 
rescue Interrupt
  #str_time = Time.now.strftime("[%Y-%m-%d %H:%M]")
  #bot.post("end"+str_time,nil,nil)
  exit 1
end
