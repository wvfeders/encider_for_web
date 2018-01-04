require "sinatra"

get '/' do
    erb  :encoderhome  #calls the erb file encoderhome.erb that is stored in the views folder
end

post '/validate' do

	redirect '/validate1?message=' + params[:a_message] + '&code=' + params[:a_code]
 	 #assigns the value in 'a_number' to 'number' 
	
	
 
end
 
 get '/validate1' do

 @code_decode = params[:code] #creates a variable from the number input
 @message = params[:message] #creates a string aray containing the isbn number

@split_letters = @message.split('') #divides message into individual letters and spaces
@letter_count = @split_letters.count


@inmessage = Array.new #establishes the inmessage aray
@out_message = Array.new #establishes the out_message array

if @code_decode == "decode"
	letter_offset = -1 * @letter_count #the sign of the letter_offset value is reversed if program is decoding 

else letter_offset = @letter_count

 end	


 count=0
 (@split_letters.count).times do #loops program the number of letters and spaces

 letter = @split_letters[count] #letter variable contains an individual letter dependent on the value of count
 count = count + 1 #increments the counter


 hash1 = {"a" => 1, "b" => 2, "c" =>3, "d" => 4, "e" => 5, "f" => 6, "g" => 7, "h" => 8,
 "i" => 9, "j" => 10, "k" =>11, "l" => 12, "m" => 13, "n" => 14, "o" =>15, "p" => 16,
 "q" => 17, "r" => 18, "s" =>19, "t" => 20, "u" => 21, "v" => 22, "w" =>23, "x" => 24,
 "y" => 25, "z" => 26, " " => 27} #establishes a hash relating a, b c with 1, 2, 3


 letter_number = hash1[letter] #Letter number contains the number of each letter in the message 

 if letter_number == 27
	then coded_letter_number = 27 # letter_number 27 refers to the space and is maintained as such
else	
	coded_letter_number = (letter_number + letter_offset)%26 #adds offset to letter number. The %26 adjusts letter number for negative values or values above 26
end

 if coded_letter_number == 0 then coded_letter_number = 26 #adjusts for instances when number is 0 
 end

 hash3 = hash1.invert #hash3 inverts hash1 so we can extract a letter from a number input

 encoded_letter = hash3[coded_letter_number] #retrieves a letter from hash3 depending on the value of coded_letter_number 

if @code_decode == "decode"	 #Theses lines determine the messages that will be output depending on whether encoding or decoding
	@input = "Your encoded message is:"
	@result = "Your decoded message is:"
else @result = "Your encoded message is:"
	@input = "Your message is:"
 end

@inmessage = @inmessage.push(letter) #collects the input letters into an array
@out_message = @out_message.push(encoded_letter) #collects the utput leters into an array
@insmessage = @inmessage.join #joins letters together from an array into a single word
@outsmessage = @out_message.join #joins letters together from an array into a single word
end
erb :message
	

end

