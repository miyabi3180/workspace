#coding: utf-8

require "./wordcheck.rb"

checker = Checker.new()
checker.find_word("にゃんこ可愛い","log.txt","favword.txt")
checker.find_max("clean.txt")
checker.find_min("clean.txt")
checker.clean_word("log2014-11-23.txt","clean2014-11-23.txt")