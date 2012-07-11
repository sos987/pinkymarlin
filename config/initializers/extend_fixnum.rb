class Fixnum
	def word words
		n = self % 100
		ending = words[2]
	    if (n<11 || n>19)
	        n = n % 10;
	        if n == 1 
	        	ending = words[0]
	        elsif n < 5 && n != 0
	        	ending = words[1]
	        else
	        	ending = words[2]
	        end
	    end
	    self.to_s+' '+ending
	end
end