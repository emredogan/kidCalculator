//
//  Errors.swift
//  KidCalc
//
//  Created by Emre Dogan on 04/04/2022.
//

import Foundation

enum ValidationError: Error {
    case divisionByZero
    case emptyEquation
    case consecutiveOperation
    case enterOperation
    case defaultError
}
