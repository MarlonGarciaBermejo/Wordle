//
//  ViewController.swift
//  Wordle
//
//  Created by Marlon Garcia-Bermejo on 2023-03-20.
//

import UIKit

class ViewController: UIViewController {
    
    let segueIdgoToPlay = "goToPlay"

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

   
    @IBAction func startGameButton(_ sender: UIButton) {
        performSegue(withIdentifier: segueIdgoToPlay, sender: self)
    }
    
}

