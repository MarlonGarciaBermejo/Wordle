//
//  GameViewController.swift
//  Wordle
//
//  Created by Marlon Garcia-Bermejo on 2023-03-21.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var randomWordLabel: UILabel!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var timer: Timer?
    var remainingTime: Int = 0
    let interval = 3.0
    var currentScore = 0
    var isTyping = false
    var highestScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
        typeTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        let userDefaults = UserDefaults.standard
        highestScore = userDefaults.integer(forKey: "highestScore")
        scoreLabel.text = "\(highestScore)"
    }
    
    @objc func updateWord() {
        if remainingTime <= 0 {
            let word = randomWord()
            randomWordLabel.text = word
            remainingTime = Int(interval)
            typeTextField.text = ""
        } else {
            remainingTime -= 1
        }
        timerLabel.text = "\(remainingTime) seconds"
    }
    
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
    
    func startTimer() {
        remainingTime = Int(interval)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateWord), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func saveHighestScore(_ highestScore: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(highestScore, forKey: "highestScore")
        userDefaults.synchronize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHighScore" {
            if let destinationVC = segue.destination as? ScoreViewController {
                destinationVC.highestScore = highestScore
            }
        }
    }
    
    @IBAction func showHighScore(_ sender: Any) {
        performSegue(withIdentifier: "showHighScore", sender: self)
    }
    
    func randomWord() -> String? {
        var words = ["apple", "banana", "cherry", "orange", "grape","lion","hamster","octupus","dedication","Elephant", "Coffee", "Rainbow", "Guitar", "Umbrella", "Butterfly", "Cinnamon", "Galaxy", "Piano", "Sandal", "Lemonade", "Camera", "Broccoli", "Dragonfly", "Watermelon", "Falcon", "Candle", "Cherry", "Cactus", "Raincoat", "Fireworks","Backpack", "Mushroom","Kangaroo", "Lighthouse", "Sapphire", "Giraffe", "Croissant", "Penguin", "Velvet", "Sushi", "Pineapple", "Eagle", "Lioness", "Violet", "Bicycle", "Comet", "Jaguar", "Hazelnut", "Daisy", "Lobster", "Glitter"]
        // So the words won't repeat twice
        guard !words.isEmpty else {
            return nil
        }
        
        let index = Int.random(in: 0..<words.count)
        let word = words[index]
        words.remove(at: index)
        return word
    }
}




