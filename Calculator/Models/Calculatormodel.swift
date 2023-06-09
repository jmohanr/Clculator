//
//  Calculatormodel.swift
//  Calculator
//
//  Created by Kaplan2 on 08/06/23.
//

import Foundation
import SwiftUI

enum Keys: String {
case one = "1"
case two = "2"
case three = "3"
case four = "4"
case five = "5"
case six = "6"
case seven = "7"
case eight = "8"
case nine = "9"
case zero = "0"
case add = "+"
case subtract = "-"
case divide = "÷"
case multiply = "x"
case equal = "="
case clear = "AC"
case decimal = "."
case percent  = "%"
case negative = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add,.subtract,.multiply,.divide,.equal:
            return Color("Voperator")
        case .clear,.negative,.percent:
            return Color("Hoperator")
        default:
            return Color("NumKey")
        }
    }
}

enum Operation {
    case add,subtract,multiply,divide,percentage,none
    
    func finalvalue(runValue: Double, currValue: Double = 0,operation: Operation) -> Double {
        switch self {
        case .add:
            return Operation.preciseRound(runValue + currValue)
        case .subtract:
            return Operation.preciseRound(runValue - currValue)
        case .divide:
            return Operation.preciseRound(runValue/currValue)
        case .multiply:
            return Operation.preciseRound(runValue * currValue)
        case.percentage:
            return runValue/100
        default:
            return runValue
        }
    }
    
    func operation(key:Keys) -> Self {
        switch key {
        case .add:
            return .add
        case .subtract:
            return .subtract
        case .multiply:
            return .multiply
        case .divide:
            return .divide
        default:
            return .none
        }
    }
    
    public enum RoundingPrecision {
        case ones
        case tenths
        case hundredths
    }
    public  static func preciseRound(
        _ value: Double,
        precision: RoundingPrecision = .tenths) -> Double
    {
        switch precision {
        case .ones:
            return round(value)
        case .tenths:
            return round(value * 10) / 10.0
        case .hundredths:
            return round(value * 100) / 100.0
        }
    }
}

enum ColorCode: String {
case v = "Voperator"
    case h = "Hoperator"
    case n = "NumKey"
}
