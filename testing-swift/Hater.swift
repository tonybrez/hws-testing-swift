//
//  Hater.swift
//  testing-swift
//
//  Created by Anthony Benitez-Rodriguez on 7/16/23.
//

import Foundation

struct Hater {
    var hating = false

    mutating func hadABadDay() {
        hating = true
    }

    mutating func hadAGoodDay() {
        hating = false
    }
}
