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
    
    var calcLogic: CalculationLogic = CalculationLogic()
    var helper: Helper = Helper()
    var operations: String = ""
    
    let preferencesInfoText = "info_text_shown"
    
    
    @IBOutlet var imageButtons: [UIButton]!
    @IBOutlet weak var calculatorOperations: UILabel!
    @IBOutlet weak var calculatorResult: UILabel!
    
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupAnimations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Helper.readFromPreferences(key: preferencesInfoText) == nil{
            helper.customInfo(header: "Warning", subtitle: "This is a simplified calculator for kids, therefore ignores the decimals.")
            Helper.writeToPreferences(key: preferencesInfoText, value: true)
        }
    }
    
    @IBAction func numberClicked(_ sender: UIButton) {
        addToOperations(value: String(sender.tag))
    }
    
    @IBAction func equalClicked(_ sender: Any) {
        if let result = calcLogic.calculate(operations: operations) {
            calculatorResult.text = result
        } else {
            helper.customAlert(header: "Problem", subtitle: "You entered an invalid input or the number is too big for me to calculate :)")
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
        if(button.tag == 10) { // Erase
            helper.playAudioAsset("eraser_sound")
            
        } else {
            helper.playAudioAsset("button_sound")
        }
        
        
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



