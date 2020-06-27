# TOP-Ruby-Hangman
Hangman game for The Odin Project ruby programming

**User Interface:**\
Users will have to guess a word (between 5 to 12 characters) randomly selected from a dictionary file. Every round, players can make a guess of a letter and display will update to show if letter chosen was correct or not. If out of guesses, players lose

**Input**:\
Player's choice of letter

**Output**:\
Ask for player for choice of letter. Display showing previously selected incorrect letters as well as correct letters and their position in the word chosen, and the number of guesses left before game ends

**Pseudocode**:\
Choosing of words:
1. Open dictionary file
2. Split the file string into individual strings 
3. Add strings that are between 5 to 12 characters into an array
4. Randomly select 1 word from the array

Gameplay:
* Player will have 8 chances to guess the correct word, do the following while there are still rounds left or until word is correctly guessed
    1. Take in player's guess
        * Convert guess to upper case and then check if input is a letter or that letter has not been used, if so ask player to retry
    2. Check if word contains the letter guessed
    3. If no, inform player of incorrect guess and reduce number of guesses by 1. If yes, inform player of correct guess
    4. Display position of guessed letter in words, for letters still not guessed, display _ in that appropriate position. Also display incorrect letters guessed
    5. Display number of guesses left
* Inform if player won or lost the game