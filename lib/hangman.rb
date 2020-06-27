require 'yaml'

class Hangman

  def initialize(chosen_word = select_random_word(process_text_file("../5desk.txt")),
                  guesses_left = 8, correct_guesses = [], wrong_guesses = [])
    @chosen_word = chosen_word
    @guesses_left = guesses_left
    @correct_guesses = correct_guesses
    @wrong_guesses = wrong_guesses
    puts "Type save if you want to save game or load to load previously saved game"
    while @guesses_left > 0
      guess = take_player_input()
      while (@wrong_guesses.include? guess) || (@correct_guesses.include? guess)
        puts "You have already chosen #{guess} before. Please choose another letter"
        guess = take_player_input()
      end 
      if @chosen_word.include? guess
        puts "You're right!"
        @correct_guesses.append guess
        if (@chosen_word.split("").uniq - @correct_guesses) == [] #check if all letters have been guessed
          puts "You have guessed it! The correct word is #{@chosen_word}!"
          break
        end
      else 
        puts "#{guess} is not found in the hidden word!"
        @wrong_guesses.append guess
        @guesses_left -= 1
        if @guesses_left == 0
          puts "You ran out of guesses! The correct word is #{@chosen_word}"
          break
        end
      end
      display_status
    end
  end

  def process_text_file(file)
    appropriate_words = []

    content = File.readlines file
    content.each do |word|
      processed_word = word.upcase.chomp #remove /n/r
      if processed_word.length > 5 && processed_word.length < 12
        appropriate_words.append(processed_word)
      end
    end
    return appropriate_words
  end

  def select_random_word(dictionary)
    return dictionary[rand(dictionary.length - 1)].upcase
  end 

  def display_current_guess
    display = @chosen_word.chars.map { |char| 
      unless @correct_guesses.include? char
        char = "_ "
      else
        char = char + " "
      end
      char
    }
    return display.join
  end

  def take_player_input()
    guess = ""
    loop do 
      puts "Please choose a letter"
      guess = gets.chomp
      if guess == "save"
        save_file
      end
      if guess == "load"
        load_file
      end
      break if guess =~ /\A[A-Za-z]?\z/ && guess.length > 0 #check if input is a single letter and is not ""
    end
    return guess.upcase
  end 

  def display_status
    puts "Current guess: #{display_current_guess}"
    puts "Correct guess: #{@correct_guesses}"
    puts "You have #{@guesses_left} guesses left"
    puts "Incorrect letters guessed: #{@wrong_guesses}"
  end

  def save_file
    save_string = YAML.dump ({
    :chosen_word => @chosen_word,
    :guesses_left => @guesses_left,
    :correct_guesses => @correct_guesses,
    :wrong_guesses => @wrong_guesses
    })
    saved_file = File.open("../save.txt", "w")
    saved_file.puts save_string
    saved_file.close
    puts "Your game has been saved!"
  end

  def load_file
    saved_file = File.open("../save.txt", "r")
    saved_string = saved_file.read
    data = YAML.load saved_string
    @chosen_word = data[:chosen_word]
    @guesses_left = data[:guesses_left]
    @correct_guesses = data[:correct_guesses]  
    @wrong_guesses = data[:wrong_guesses]
    puts "Game loaded!"
    display_status
  end
end

Hangman.new

