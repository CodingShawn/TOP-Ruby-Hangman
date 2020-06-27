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

def display_current_guess(chosen_word, correct_guesses = [])
  display = chosen_word.chars.map { |char| 
    unless correct_guesses.include? char
      char = "_"
    end
    char
  }
  return display
end

def take_player_input(previous_guess)
  guess = ""
  loop do 
    puts "Please choose a letter"
    guess = gets.chomp
    break if guess =~ /\A[A-Za-z]?\z/ #check if input is a single letter
  end
  return guess.upcase
end

def game
  chosen_word = select_random_word(process_text_file("../5desk.txt"))
  guesses_left = 8
  correct_guesses = []
  wrong_guesses = []
  while guesses_left > 0
    guess = take_player_input()
    if previous_guess.include? guess
      puts "You have already chosen #{guess} before. Please choose another letter"
      guess = take_player_input()
    end 
    if chosen_word.include? guess
      puts "You're right!"
    


