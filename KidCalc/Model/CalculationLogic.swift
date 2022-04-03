//
//  CalculationLogic.swift
//  KidCalc
//
//  Created by Emre Dogan on 03/04/2022.
//

import Foundation


struct CalculationLogic {
    
    var operations : String = ""
    
    mutating func calculate(operations: String) -> String? {
        self.operations = operations
        if validInput() {
            let expression = NSExpression(format: operations)
            if let result = expression.expressionValue(with: nil, context: nil) as? Double {
                let resultString = formatResult(result: result)
                return resultString
            } else {
               return nil
            }
            
            
        } else {
            return nil
        }
    }
    
    func validInput() ->Bool
    {
        var count = 0
        var funcCharIndexes = [Int]()
        
        if operations.contains("/0") { // Division by zero case
            return false
        }
        
        if operations == "" {
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
    
    func formatResult(result: Double) -> String {
        return String(format: "%.0f", result)
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
}
