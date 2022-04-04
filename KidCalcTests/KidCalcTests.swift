//
//  KidCalcTests.swift
//  KidCalcTests
//
//  Created by Emre Dogan on 04/04/2022.
//

import XCTest
@testable import KidCalc

class KidCalcTests: XCTestCase {
    var calcLogic: CalculationLogic  = CalculationLogic()
    
    func test_is_valid_input() {
        XCTAssertNoThrow(try calcLogic.calculate(operations: "2+4"))
    }
    
    func test_is_invalid_input_division_by_zero() {
        var error: ValidationError?
        let expectedError = ValidationError.divisionByZero
        XCTAssertThrowsError(try calcLogic.calculate(operations: "2/0")) { thrownError in
            error = (thrownError as? ValidationError)!
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    func test_is_invalid_input_empty_equation() {
        var error: ValidationError?
        let expectedError = ValidationError.emptyEquation
        XCTAssertThrowsError(try calcLogic.calculate(operations: "")) { thrownError in
            error = (thrownError as? ValidationError)!
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    func test_is_invalid_input() {
        var error: ValidationError?
        let expectedError = ValidationError.consecutiveOperation
        XCTAssertThrowsError(try calcLogic.calculate(operations: "8++")) { thrownError in
            error = (thrownError as? ValidationError)!
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    
    
    

}
