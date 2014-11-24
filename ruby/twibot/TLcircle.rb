require "./wordcheck.rb"
require 'cairo'
include Math

def make_circle(input_path,output_path)
	random = Random.new
	checker = Checker.new()
	format  = Cairo::FORMAT_ARGB32
	width   = 600
	height  = 400
	surface = Cairo::ImageSurface.new(format, width, height)
	context = Cairo::Context.new(surface)
	
	context.set_source_rgb(1, 1, 1)
 	context.rectangle(0, 0, width, height)
 	context.fill
 	context.translate(width/2,height/2)

	c1=0.5
	c2=0.5
	c3=0.5

	x   = 0
	y   = 0
	t   = 0
	b_t = 0
	r   = 0
	i   = 0
	File.open(input_path,"r") do |file|
		file.each_line do |line|
			i+=1
			context.set_source_rgb(c1,c2,c3)

			line= line.chomp()
			line= line.split("\s")
			b   = line[0].size()
			t  += 10*line[1].to_i
			r  += b

			context.move_to(0,0)
			context.line_to(r*cos(b_t*PI/180),r*sin(b_t*PI/180))
			context.stroke
			x=r*cos(b_t*PI/180)
			y=r*sin(b_t*PI/180)
			bx=x
			by=y
			
			context.move_to(0,0)
 			context.arc(0,0,r,b_t*PI/180,t*PI/180)
			context.stroke
			x=bx*cos((t-b_t)*PI/180)-by*sin((t-b_t)*PI/180)
			x=bx*sin((t-b_t)*PI/180)+bx*cos((t-b_t)*PI/180)

			b_t=t
			ans = random.rand(3)
			puts ans
			if ans == 0
				c1+=0.01*random.rand(10)
				c1=0 if c1>1
			elsif ans == 1
				c2+=0.01*random.rand(10)
				c2=0 if c2>1
			else
				c3+=0.01*random.rand(10)
				c3=0 if c3>1
			end
			puts c1
			puts c2
			puts c3

		end
	end
	surface.write_to_png(output_path)
end