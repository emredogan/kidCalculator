//
//  ViewController.swift
//  KidCalc
//
//  Created by Emre Dogan on 02/04/2022.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    var audioPlayer: AVAudioPlayer!

    
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
            if let result = expression.expressionValue(with: nil, context: nil) as? Double {
                let resultString = formatResult(result: result)
                calculatorResult.text = resultString
            } else {
                let alert = UIAlertController(title: "Invalid input", message: "Calculator does not understand the input", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            
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
        
        if operations.contains("/0") { // Division by zero case
            return false
        }
        
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
        return String(format: "%.0f", result)
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
            
            button.addTarget(self, action: #selector(animate), for: .touchUpInside)
            
        }
    
    }
    
    @objc func animate(button: UIButton) {
        button.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 10.0])
        playAudioAsset("button_sound")
        
        
    }
    
    func playAudioAsset(_ assetName : String) {
          guard let audioData = NSDataAsset(name: assetName)?.data else {
             fatalError("Unable to find asset \(assetName)")
          }

          do {
             audioPlayer = try AVAudioPlayer(data: audioData)
             audioPlayer.play()
          } catch {
             fatalError(error.localizedDescription)
        }
    }
    
    
}

extension UIView {
    
    
    // Using CAMediaTimingFunction
    func shake(duration: TimeInterval = 0.5, values: [CGFloat]) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        
        // Swift 4.2 and above
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        // Swift 4.1 and below
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        
        animation.duration = duration // You can set fix duration
        animation.values = values  // You can set fix values here also
        self.layer.add(animation, forKey: "shake")
    }
    
    
    // Using SpringWithDamping
    func shake(duration: TimeInterval = 0.5, xValue: CGFloat = 12, yValue: CGFloat = 0) {
        self.transform = CGAffineTransform(translationX: xValue, y: yValue)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        
    }
    
    
    // Using CABasicAnimation
    func shake(duration: TimeInterval = 0.05, shakeCount: Float = 6, xValue: CGFloat = 12, yValue: CGFloat = 0){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = shakeCount
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - xValue, y: self.center.y - yValue))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + xValue, y: self.center.y - yValue))
        self.layer.add(animation, forKey: "shake")
    }
    
}

