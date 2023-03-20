//
//  ViewController.swift
//  Wordle
//
//  Created by Marlon Garcia-Bermejo on 2023-03-20.
//

import UIKit

class ViewController: UIViewController {
    
    let segueIdgoToGame = "goToGame"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

   
    @IBAction func startGameButton(_ sender: UIButton) {
        performSegue(withIdentifier: segueIdgoToGame, sender: self)
    }
    
}

