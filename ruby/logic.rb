# coding:utf-8

## kind:return kind of mark
def kind(mark)
	if	mark==nil
		return nil
	end
	mark=mark.tr("a-z","1")
	mark=mark.tr("B-C","2")
	mark=mark.tr("F-O","3")
	mark=mark.tr("P-Z","4")
	mark=mark.tr("*"  ,"4")
	mark=mark.tr("&"  ,"5")
	mark=mark.tr("|"  ,"5")
	mark=mark.tr("$"  ,"5")
	mark=mark.tr(">"  ,"5")
	mark=mark.tr("~"  ,"5")
	mark=mark.tr("("  ,"5")
	mark=mark.tr(")"  ,"5")
	if mark == "1"
		return "x"
	elsif mark == "2"
		return "n"
	elsif mark == "3"
		return "p"
	elsif mark == "4"
		return "s"
	elsif mark == "5"
		return "c"
	else
		return nil
	end
end
##clean:make str clear
def clean(str)
	if str == nil
		return nil
	end
	
	c=0
	for k in 0..str.size() do
		if str[k]=="("
			c+=1
		elsif str[k]==")"
			c-=1
		end
	end
	if c != 0
		return nil
	end
	
	str=str.tr("\n" ,"")
	str=str.tr("\s" ,"")
	str=str.tr("0-9","")
	str=str.tr("*"  ,"")
	str=str.tr(","  ,"")
	str=str.tr("."  ,"")
	str=str.tr("@"  ,"")
	return str
end
##judge setence is ok or not ok
def judge(str)
	str=clean(str)
	if str==nil
		return nil
	end

	mono = Array.new()
	c=0
	f=0

	i=0
	while i<str.size()
		if kind(str[i])=="p"
			if kind(str[i+1])=="x"||kind(str[i+1])=="n"
				mono[c]=str[i,2]
				str[i,2]="*"
				c+=1
			end
		elsif kind(str[i])=="s"
				mono[c]=str[i]
				str[i]="*"
				c+=1
		end
		i+=1
	end

	i=0
	while i<str.size()&&f<1000
		if str[i]=="~"
			if str[i+1]=="*"
				str[i,2]="*"
				i=-1
			end
		elsif str[i]=="*"
			if str[i+1]=="&"||str[i+1]=="|"
				if str[i+2]=="*"
					str[i,3]="*"
					i=-1
				end
			elsif str[i+1]=="$"||str[i+1]==">"
				if str[i+2]=="*"&&str[i-1]!="&"&&str[i-1]!="|"
					str[i,3]="*"
					i=-1
				end
			end
		elsif str[i]=="("
			if str[i+1]=="*"&&str[i+2]==")"
				str[i,3]="*"
				i=-1
			end
		elsif str[i]=="A"||str[i]=="E"
			if kind(str[i+1])=="x"&&str[i+2]=="*"
				str[i,3]="*"
				i=-1
			end
		end
		i+=1
		f+=1
	end
	puts str
	puts "turn="+f.to_s
	if str == "*"
		puts "notation is ok"
		return mono
	else
		puts "notation is not ok"
		return nil
	end
end

def devide(str)
	if judge(str)==nil
		return nil
	end
	i = 0
	a=nil
	b=nil
	while i<str.size()
		if judge(str[0..i])!=nil && str[i+1]!="&" && str[i+1]!="|"
			a = str[0..i]
			break
		end
		i+=1
	end
	if a == str
		return nil
	end
	b = str[i+2,1000]
	return [a,b]
end





def MP(str1,str2)
	if judge(str1)==nil || judge(str2)==nil
		return nil
	end
	i = 0
	while i<str1.size()
		if judge(str1[0..i])!=nil && str1[i+1]!="&" && str1[i+1]!="|"
			a = str1[0..i]
			break
		end
		i+=1
	end
	b = str1[i+2,1000]
	if a == str2
		return b
	else
		return nil
	end
end
def MT(str1,str2)
	if judge(str1)==nil || judge(str2)==nil
		return nil
	end
	i = 0
	while i<str1.size()
		if judge(str1[0..i])!=nil && str1[i+1]!="&"&&str1[i+1]!="|"
			a = str1[0..i]
			break
		end
		i+=1
	end
	b = "~("+str1[i+2,1000]+")"
	b=clean(b)
	str2=clean(str2)
	if b == str2
		a="~("+a+")"
		a=clean(a)
		return a
	else
		return nil
	end
end
def R(str)
	if judge(str)==nil
		return nil
	end
	return str
end
def DN(str)
	if judge(str)==nil
		return nil
	end
	if str[0,2]=="~~"
		str[0,2]=""
		return str
	elsif str[0,2]!="~~"
		str="~~"+str
		return str
	else
		nil
	end
end
