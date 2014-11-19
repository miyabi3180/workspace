#coding: utf-8
require "MeCab"

class Checker
	def initialize()
		@mecab = MeCab::Tagger.new()
	end
	def find_word(text,path)
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
    				File.open("wordlog.txt","a") do |file|
      				file.write(surface+"\n")
    				end
  			end
  			node = node.next
		end

		for i in 0..(n_t-1)
			File.open(path,"r") do |file|
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
	
	def clean_word(path)
		baf = Array.new()
		n=0
		count=0
		return nil if path == nil
		File.open(path,"r") do |file|
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

		File.open("clean.txt","w") do |file|
			i=0
      		while baf[i]!=""
      			file.write(baf[i]+"\n")
      			i+=1
      		end
    		end
	end
end