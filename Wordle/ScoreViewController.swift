//
//  ScoreViewController.swift
//  Wordle
//
//  Created by Marlon Garcia-Bermejo on 2023-03-22.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var highestScoreLabel: UILabel!
    
    var highestScore: Int = 0
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            // high score previewed on this view taken from GameViewController using UserDefault

        highestScoreLabel.text = "High Score: \(highestScore)"
        
        let highestScore = UserDefaults.standard.integer(forKey: "highestScore")
           highestScoreLabel.text = "High Score: \(highestScore)"
        
        
       
        }

    
    }

