//
//  ViewController.swift
//  KidCalc
//
//  Created by Emre Dogan on 02/04/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageButtons: [UIButton]!
    
    var operations: String = ""
    
    @IBOutlet weak var calculatorOperations: UILabel!
    @IBOutlet weak var calculatorResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupImageTypeForButtons()
        
    }
    
    func setupImageTypeForButtons() {
        for button in self.imageButtons {
            print("CHANGING")
            button.contentHorizontalAlignment = .fill
            button.contentVerticalAlignment = .fill
            button.imageView?.contentMode = .scaleAspectFit
        }
    }
    
}

