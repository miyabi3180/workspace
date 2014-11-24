#coding:utf-8

require './bot.rb'
require './TLcircle.rb'
require "./wordcheck.rb"

checker = Checker.new()
bot = Bot.new()
str_time = Time.now.strftime("[%Y-%m-%d %H:%M]")
log = "log"+Time.now.strftime("%Y-%m-%d")+".txt"
output = "clean"+Time.now.strftime("%Y-%m-%d")+".txt"
draw = "TLcircle"+Time.now.strftime("%Y-%m-%d")+"png"
checker.clean_word(log,output)
make_circle(output,draw)
bot.post_pic("TLcircle"+str_time+"\n",draw,nil,nil)
