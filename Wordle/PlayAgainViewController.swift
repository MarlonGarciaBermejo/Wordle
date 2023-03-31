//
//  PlayAgainViewController.swift
//  Wordle
//
//  Created by Marlon Garcia-Bermejo on 2023-03-23.
//

import UIKit

class PlayAgainViewController: UIViewController {

    
    //labels and buttons
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    //score from previous game implemented into this view
    var previousScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalScoreLabel.text = "You scored: \(previousScore)!"  // High score label + previousScore from GameViewController
        
        
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
