//
//  CalculationLogic.swift
//  KidCalc
//
//  Created by Emre Dogan on 03/04/2022.
//

import Foundation


struct CalculationLogic {
    
    var operations : String = ""
    
    mutating func calculate(operations: String) throws -> String? {
        self.operations = operations
        do {
            if try validInput() {
                let expression = NSExpression(format: operations)
                if let result = expression.expressionValue(with: nil, context: nil) as? Double {
                    let resultString = formatResult(result: result)
                    return resultString
                }
                
                
            }
            
        } catch let mathError as ValidationError {
            switch mathError {
                
            case .divisionByZero:
                throw ValidationError.divisionByZero
            case .emptyEquation:
                throw ValidationError.emptyEquation
            case .consecutiveOperation:
                throw ValidationError.consecutiveOperation
            case .enterOperation:
                throw ValidationError.enterOperation
            case .defaultError:
                throw ValidationError.defaultError
            }
            
        } catch {
            print(error)
        }
        
        return nil
        
    }
    
    func validInput() throws ->Bool
    {
        var count = 0
        var funcCharIndexes = [Int]()
        
        if operations.contains("/0") { // Division by zero case
            throw ValidationError.divisionByZero
        }
        
        if operations == "" {
            throw ValidationError.emptyEquation
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
                throw ValidationError.enterOperation
            }
            
            if(index == operations.count - 1)
            {
                throw ValidationError.consecutiveOperation
            }
            
            if (previous != -1)
            {
                if(index - previous == 1)
                {
                    throw ValidationError.defaultError
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
