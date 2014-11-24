# coding:utf-8

require './bot.rb'
require './BF.rb'
require './wordcheck.rb'

bot = Bot.new()
my_id = "@"+bot.name()
ch = Checker.new()

begin
  bot.timeline.userstream do |status|
 
    twitter_id = status.user.screen_name
    name       = status.user.name
    contents   = status.text
    status_id  = status.id
 
    # except RT
    if !contents.index("RT")
      str_time = Time.now.strftime("[%Y-%m-%d %H:%M]")
      title = "log"+Time.now.strftime("%Y-%m-%d")+".txt"
 
      # except REPLY TO OTHERS + REACTION TIMELINE
      if !(/^@\w*/.match(contents))
        puts contents+"\n"

        #fav action
        if ch.find_word(contents,title,"favword.txt")
          bot.fav(status_id)
        end

        #reply action
        if contents =~ /まーぼう/
          puts "c\n"
          text = "なんだそのおち\n#{str_time}"
          bot.post(text,twitter_id,status_id)
        end
      end
 
      # REPLY TO ME
      if contents =~ /^#{my_id}\s*/
        if contents =~/ほげ/
          bot.post("reply"+str_time,nil,nil)
          text = "はい\n #{str_time}"
          bot.fav(status_id)
          bot.post(text,twitter_id,status_id)
        end
        if contents =~ /^\sBF\s/
          bot.post("BF"+str_time,nil,nil)
          text = contents.tr("#{my_id}","")
          text = contents.tr("BF","")
          text = contents.tr("\s","")
          text = contents.tr("\n","")
          text = BF(text)
          bot.post(text,twitter_id,status_id)
        end
      end
 
    end
  sleep 2
  end
rescue => em
  p em
  sleep 2
  retry
 
rescue Interrupt
  exit 1
end
