### Swift Application Project "Wordle Game"

Brief explanation of my code and what it does! 

This code is a Swift implementation for a word game. The game is about generating random words and giving the user a limited time to type the correct word. The game has a score system that is updated based on the user's performance, and the highest score is saved using UserDefaults. The game has a timer to keep track of the remaining time, and it is implemented using the Timer class. Once the timer runs out, the game ends, and the user can either play again or quit. The code also has a function to generate random words.

The code connects the game's UI elements using the @IBOutlet property wrapper. The typeTextField is the text field where the user types the words, and the randomWordLabel displays the random word that the user needs to type. The scoreLabel displays the user's score, and the timerLabel and timeRemainingLabel display the remaining time for typing the word and the remaining time for the game, respectively.

The GameViewController class has several properties and methods to implement the game's logic. The startTimer function is responsible for starting the timer with a given duration. The updateTimeRemainingLabel function is responsible for updating the remaining time label and ending the game if the time runs out. The updateWord function is called by the timer to update the random word and the remaining time. The textFieldDidChange function is called every time the user types in the typeTextField, and it updates the score and the random word based on the user's input. The saveHighestScore function saves the highest score using UserDefaults, and the prepare function prepares the PlayAgainViewController for the user to play again or quit.

Finally, the randomWord function generates a random word from a list of words.
<img width="1061" alt="WordleBG" src="https://user-images.githubusercontent.com/94327966/229183012-9676e546-ef97-4b13-bce9-75f839057308.png">

### TOOLS USED:
[![My Skills](https://skillicons.dev/icons?i=swift,photoshop)](https://skillicons.dev)

### PARTICIPANTS:
<a href="https://github.com/MarlonGarciaBermejo/Wordle/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=MarlonGarciaBermejo/Wordle" />
</a>
