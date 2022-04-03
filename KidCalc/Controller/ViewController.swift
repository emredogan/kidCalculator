//
//  ViewController.swift
//  KidCalc
//
//  Created by Emre Dogan on 02/04/2022.
//

import UIKit
import AVFoundation
import SCLAlertView


class ViewController: UIViewController {
    
    
    var audioPlayer: AVAudioPlayer!
    
    var calcLogic: CalculationLogic = CalculationLogic()

    
    @IBOutlet var imageButtons: [UIButton]!
    
    var operations: String = ""
    
    @IBOutlet weak var calculatorOperations: UILabel!
    @IBOutlet weak var calculatorResult: UILabel!
    
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupAnimations()
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
        if let result = calcLogic.calculate(operations: operations) {
            calculatorResult.text = result
        } else {
            customAlert()
        }
    }
    
    @IBAction func eraseClicked(_ sender: Any) {
        clearAll()
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
        calculatorOperations.fadeTransition(0.5)
        calculatorResult.fadeTransition(0.5)
        operations = ""
        calculatorResult.text = ""
        calculatorOperations.text = ""
    }
    
    func addToOperations(value: String) {
        operations += value
        calculatorOperations.text = operations
    }
    
    func setupButtons() {
        for button in self.imageButtons {
            button.contentHorizontalAlignment = .fill
            button.contentVerticalAlignment = .fill
            button.imageView?.contentMode = .scaleAspectFit
            button.addTarget(self, action: #selector(animate), for: .touchUpInside)
        }
    
    }
    
    @objc func animate(button: UIButton) {
        button.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 10.0])
        if(button.tag == 1) { // Erase
            playAudioAsset("eraser_sound")
            
        } else {
            playAudioAsset("button_sound")
        }
        
        
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
    
    func customAlert() {
        SCLAlertView().showError("Problem!", subTitle: "You entered an invalid input or the number is too big for me to calculate :)") // Error
    }
    
    private func setupAnimations() {
        let animation: CATransition = CATransition()
        animation.duration = 1.0
        animation.type = CATransitionType.fade
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        calculatorOperations.layer.add(animation, forKey: "changeTextTransition")
        
        let animation2: CATransition = CATransition()
        animation2.duration = 1.0
        animation2.type = CATransitionType.fade
        animation2.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        calculatorResult.layer.add(animation2, forKey: "changeTextTransition")
    }
    
    
}



