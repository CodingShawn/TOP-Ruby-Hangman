def process_text_file(file)
  appropriate_words = []

  content = File.readlines file
  appropriate_words = 
    content.each do |word|
      processed_word = word.upcase.chomp #remove /n/r
      if processed_word.length > 5 && processed_word.length < 12
        appropriate_words.append(processed_word)
      end
    end
end

def select_random_word(dictionary)
  return dictionary[rand(dictionary.length - 1)]
end 

def take_player_input()
  guess = ""
  loop do 
    puts "Please choose a letter"
    guess = gets.chomp
    break if guess =~ /\A[A-Za-z]?\z/ #check if input is a single letter
  end
  return guess
end


#word = select_random_word(process_text_file("../5desk.txt"))
word = take_player_input
print word
