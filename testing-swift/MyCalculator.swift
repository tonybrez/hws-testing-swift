//
//  MyCalculator.swift
//  testing-swift
//
//  Created by Anthony Benitez-Rodriguez on 7/23/23.
//

import Foundation

class MyCalculator {
    func divisionRemainder(of number: Int, dividedBy: Int) -> (quotient: Int, remainder: Int) {
        let quotient = number / dividedBy
        let remainder = number % dividedBy
        return (quotient, remainder)
    }
}
