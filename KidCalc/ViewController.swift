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
    
    @IBOutlet var mainView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupImageTypeForButtons()

        
    }
    
    @IBAction func oneClicked(_ sender: Any) {
        addToOperations(value: "1")
    }
    
    @IBAction func twoClicked(_ sender: Any) {
        addToOperations(value: "2")

    }
    
    @IBAction func threeClicked(_ sender: Any) {
        addToOperations(value: "3")

    }
    
    @IBAction func fourClicked(_ sender: Any) {
        addToOperations(value: "4")

    }
    
    @IBAction func fiveClicked(_ sender: Any) {
        addToOperations(value: "5")

    }
    
    @IBAction func sixClicked(_ sender: Any) {
        addToOperations(value: "6")

    }
    
    @IBAction func sevenClicked(_ sender: Any) {
        addToOperations(value: "7")

    }
    
    @IBAction func eightClicked(_ sender: Any) {
        addToOperations(value: "8")

    }
    
    @IBAction func nineClicked(_ sender: Any) {
        addToOperations(value: "9")

    }
    
    @IBAction func zeroClicked(_ sender: Any) {
        addToOperations(value: "0")

    }
    
    @IBAction func equalClicked(_ sender: Any) {
        if validInput() {
            print("OPERATIONS ", operations)
            let expression = NSExpression(format: operations)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            calculatorResult.text = resultString
        } else {
            let alert = UIAlertController(title: "Invalid input", message: "Calculator does not understand the input", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        

    }
    
    @IBAction func eraseClicked(_ sender: Any) {
        clearAll()
    }
    
    func validInput() ->Bool
        {
            var count = 0
            var funcCharIndexes = [Int]()
            
            for char in operations
            {
                if(specialCharacter(char: char))
                {
                    funcCharIndexes.append(count)
                }
                count += 1
            }
            
            var previous: Int = -1
            
            for index in funcCharIndexes
            {
                if(index == 0)
                {
                    return false
                }
                
                if(index == operations.count - 1)
                {
                    return false
                }
                
                if (previous != -1)
                {
                    if(index - previous == 1)
                    {
                        return false
                    }
                }
                previous = index
            }
            
            return true
        }
    
    func specialCharacter(char: Character) -> Bool {
        if(char == "*") {
            return true
        }
        
        if(char == "/") {
            return true
        }
        
        if(char == "+") {
            return true
        }
        
        if(char == "-") {
            return true
        }
        
        return false
    }
    
    func formatResult(result: Double) -> String {
        if(result.truncatingRemainder(dividingBy: 1) == 0) {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }
    }
    
    @IBAction func divisionClicked(_ sender: Any) {
        addToOperations(value: "/")

    }
    
    @IBAction func multiplyClicked(_ sender: Any) {
        addToOperations(value: "*")

    }
    
    @IBAction func addClicked(_ sender: Any) {
        addToOperations(value: "+")
    }
    
    @IBAction func minusClicked(_ sender: Any) {
        addToOperations(value: "-")

    }
    
    func clearAll() {
        operations = ""
        calculatorResult.text = ""
        calculatorOperations.text = ""
    }
    
    func addToOperations(value: String) {
        operations += value
        calculatorOperations.text = operations
    }
    
    func setupImageTypeForButtons() {
        for button in self.imageButtons {
            button.contentHorizontalAlignment = .fill
            button.contentVerticalAlignment = .fill
            button.imageView?.contentMode = .scaleAspectFit
        }
    }
    
}

