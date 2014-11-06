def wordcheck(str)
	flag = 0
	open( "./keyword.txt") {|f|
  	while line = f.gets
    		if str.include?(line.chomp)
    			flag = 1
    		end
    		puts "c\n"
  	end
	}
	flag
end