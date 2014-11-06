def BF(input)
	p=0
	o=0
	i=0
	f=0
	c=0
	e=0
	puts input
	input=input.tr('&','')
	input=input.tr(';','')
	input=input.tr('g','>')
	input=input.tr('l','<')
	puts input
	score=140-input.size()
	input =input.split('')
	limit =input.size()
	memory=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	output=Array.new()

	while i<limit

		if input[i]=='>'
			if p<15
				p+=1
			elsif p==15
				p=0
			end

		elsif input[i]=='<'
			if p>0
				p-=1
			elsif p==0
				p=15
			end

		elsif input[i]=='+'
			memory[p]+=1

		elsif input[i]=='-'
			memory[p]-=1

		elsif input[i]=='['
			if memory[p]==0
				i+=1
				while f<1
					if input[i]=='['
						f-=1
					elsif input[i]==']'
						f+=1
					end
					i+=1
				end
				i-=1
				f=0
			end

		elsif input[i]==']'
			if memory[p]!=0
				i-=1
				while f<1
					if input[i]==']'
						f-=1
					elsif input[i]=='['
						f+=1
					end
					i-=1
				end
				i+=1
				f=0
			end

		#elsif input[i]==','
		#	print 'input->'
		#	memory[p]=gets.chomp.to_i

		elsif input[i]=='.'
			output[c]=memory[p]
			c+=1

		elsif input[i]=='\n'

		elsif input[i]=='\s'
		
		else
			i=limit
			e=1
		end 
		i+=1
	end

	if e==0
		i=0
		limit=output.size()
		o_str=''
		while i<limit
			o_str += output[i].chr
			i+=1
		end
	else
		o_str='E'
	end
	score *= limit
	o_str += " score->"+score.to_s
	puts o_str
	o_str
end