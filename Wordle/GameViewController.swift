//
//  GameViewController.swift
//  Wordle
//
//  Created by Marlon Garcia-Bermejo on 2023-03-21.
//

import UIKit

class GameViewController: UIViewController {
    
    // connecting labels and buttons etc..
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var randomWordLabel: UILabel!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    // variables used in the code
    let segueIdgoPlayAgain = "goPlayAgain"
    var timer: Timer?
    var remainingTime: Int = 0
    let interval = 4.0
    var currentScore = 0
    var isTyping = false
    var highestScore = 0
    var timeRemaining = 23.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remainingTime = Int(interval)
        startTimer(duration: 3.0)
        typeTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        let userDefaults = UserDefaults.standard
        highestScore = userDefaults.integer(forKey: "highestScore")
        scoreLabel.text = "\(highestScore)"
    }
    // Function for the words to generate once timer runs out or the correct word has been typed
    @objc func updateWord() {
        if remainingTime <= 0 {
            let word = randomWord()
            randomWordLabel.text = word
            remainingTime = Int(interval)
            if typeTextField.text == "" {
                currentScore = max(currentScore - 1, 0)
                scoreLabel.text = "\(currentScore)"
            }
            typeTextField.text = ""
        } else {
            remainingTime -= 1
            timerLabel.text = "\(remainingTime) seconds"
            updateTimeRemainingLabel()
        }
    }

    
            // Function to check if the word is matching then score will update + or - depending on if it's the correct word.
    @objc func textFieldDidChange() {
        guard let typedText = typeTextField.text else {
            return
        }
        if typedText == randomWordLabel.text {
            if isTyping { // Only update score if user has finished typing the word
                currentScore += 1
                scoreLabel.text = "\(currentScore)"
                typeTextField.text = ""
                isTyping = false
                stopTimer()
                
                let word = randomWord()
                randomWordLabel.text = word
                remainingTime = Int(interval)
                startTimer(duration: 4.0)
                
                if currentScore > highestScore {
                    highestScore = currentScore
                    scoreLabel.text = "\(highestScore)"
                    saveHighestScore(highestScore)
                }
            }
        } else {
            isTyping = true
            if typedText.count >= randomWordLabel.text?.count ?? -1 { // Only decrease score if user has finished typing the word
                currentScore = max(currentScore - 1, 0)
                scoreLabel.text = "\(currentScore)"
                
                if currentScore > highestScore {
                    highestScore = currentScore
                    scoreLabel.text = "\(highestScore)"
                    saveHighestScore(highestScore)
                }
            }
        }
    }

    // Function to start the timer for the wording which is set to 4 seconds in the top variables, also a timer set to 23.0 seconds for the full game time. Added + 3 seconds because the countdown timer starts after 3 seconds from starting the game itself. Officially game starts on 20.0 seconds.
    func startTimer(duration: TimeInterval) {
        remainingTime = Int(duration)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateWord), userInfo: nil, repeats: true)
        if timeRemaining <= 0 {
                timeRemaining = 23.0
                updateTimeRemainingLabel()
            }
        }
    
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
        // Function for the full 23.0 seconds game timer to stop and segue to next ViewController which is the summary of the previous game you just played showing Score + Play again and quit options.
        func updateTimeRemainingLabel() {
            if timer != nil {
                  timeRemaining -= 1
                  timeRemainingLabel.text = "\(Int(timeRemaining)) seconds"
              }
              if timeRemaining <= 0 {
                  stopTimer()
                  performSegue(withIdentifier: segueIdgoPlayAgain, sender: self)
              }
          }
    // save highest score using userDefualts to show in the ScoreViewController.
    func saveHighestScore(_ highestScore: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(highestScore, forKey: "highestScore")
        userDefaults.synchronize()
    }
    
    func updateDifficultyLevel(_ level: String) {
        switch level {
        case "easy":
            timeRemaining = 40.0
        case "medium":
            timeRemaining = 25.0
        case "hard":
            timeRemaining = 15.0
        default:
            timeRemaining = 23.0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goPlayAgain" {
                if let destinationVC = segue.destination as? PlayAgainViewController {
                    destinationVC.previousScore = currentScore // preview previousScore in the PlayAgainViewController to show the summary from last game.
                
                }
            }
        }
//    // To enter the ScoreViewController
    @IBAction func showHighScore(_ sender: Any) {
        performSegue(withIdentifier: "showHighScore", sender: self)
    }
    
    // random words generating
    func randomWord() -> String? {
        var words = ["apple", "banana", "cherry", "orange", "grape","lion","hamster","octupus","dedication","Elephant", "Coffee", "Rainbow", "Guitar", "Umbrella", "Butterfly", "Cinnamon", "Galaxy", "Piano", "Sandal", "Lemonade", "Camera", "Broccoli", "Dragonfly", "Watermelon", "Falcon", "Candle", "Cherry", "Cactus", "Raincoat", "Fireworks","Backpack", "Mushroom","Kangaroo", "Lighthouse", "Sapphire", "Giraffe", "Croissant", "Penguin", "Velvet", "Sushi", "Pineapple", "Eagle", "Lioness", "Violet", "Bicycle", "Comet", "Jaguar", "Hazelnut", "Daisy", "Lobster", "Glitter"]
        
        
        guard !words.isEmpty else {
            return nil
        }
        
        let index = Int.random(in: 0..<words.count)
        let word = words[index]
        words.remove(at: index)
        return word
    }
}




