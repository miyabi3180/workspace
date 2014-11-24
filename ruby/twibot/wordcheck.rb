#coding: utf-8
require "MeCab"

#this code uses mecab

#Checker.find_word(text,path)
#->make node of "text" and save each words to "path" file if it's noun

#Checker.clean_word(path)
#->delete overlap words and arrange these.
#ex)hoge 4   this means word "hoge" appeared 4 times.

#Checker.find_max(path)
#return maxword's length, maxword's times

#Checker.find_min(path)
#return minword's length, minword's times

class Checker
	def initialize()
		@mecab = MeCab::Tagger.new()
	end
	def find_word(text,log_path,keyword_path)
		target = Array.new()
		n_t = 0
		node = @mecab.parseToNode(text)
		while node do
  			surface = node.surface
  			surface.force_encoding('UTF-8')
  			feature = node.feature.force_encoding('UTF-8')
  			part_of_speech = feature.split(',')[0]
  			if part_of_speech == "名詞"
  				target[n_t] = surface
  				n_t+=1
    				puts sprintf("%s\t[%s]", surface, part_of_speech)
    				File.open(log_path,"a") do |file|
      				file.write(surface+"\n")
    				end
  			end
  			node = node.next
		end

		for i in 0..(n_t-1)
			File.open(keyword_path,"r") do |file|
				file.each_line do |line|
					if line.chomp() == target[i]
						puts "match"
						return true
					end
				end
			end
		end
		return false
	end
	def find_max(path)
		max_length=0
		max_times=0
		File.open(path,"r") do |file|
			file.each_line do |line|
				line=line.chomp()
				line=line.split("\s")
				if line[1].to_i>max_times 
					max_times=line[1].to_i
					max_length=line[0].size()
				end		
			end
		end
		puts max_length
		puts max_times
		[max_length,max_times]
	end
	
	def find_min(path)
		min_length=100
		min_times=100
		File.open(path,"r") do |file|
			file.each_line do |line|
				line=line.chomp()
				line=line.split("\s")
				if line[1].to_i<=min_times 
					min_times=line[1].to_i
					min_length=line[0].size()
				end		
			end
		end
		puts min_length
		puts min_times
		[min_length,min_times]
	end
	def clean_word(log_path,output_path)
		baf = Array.new()
		n=0
		count=0
		return nil if log_path == nil || output_path == nil
		File.open(log_path,"r") do |file|
			file.each_line do |line|
				line=line.chomp()
				if line.ascii_only? == true || line.size()>10
					puts line
				else
					baf[n]=line
					n+=1
				end
			end
		end
		i=0
		while i<n
			count = 1
			if baf[i]!=""
				for j in (i+1)..(n-1)
					if baf[i]==baf[j]
						baf[j]=""
						count+=1
					end
				end
				baf[i]=baf[i]+"\s"+count.to_s
			else
				k=i+1
				while baf[k]==""&&k<n
					k+=1
				end
				if k!=n
					baf[i]=baf[k]
					baf[k]=""
					i-=1
				end

			end
			i+=1

		end

		File.open(output_path,"w") do |file|
			i=0
      		while baf[i]!=""&&baf[i]!=nil
      			file.write(baf[i]+"\n")
      			i+=1
      		end
    		end
	end
end