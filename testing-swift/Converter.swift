//
//  Converter.swift
//  testing-swift
//
//  Created by Anthony Benitez-Rodriguez on 7/23/23.
//

import Foundation

struct Converter {
    func convertToCelsius(fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * 5 / 9
    }
    
    func convertToCelsiusUsingFoundation(fahrenheit: Double) -> Double {
        let fahrenheit = Measurement(value: fahrenheit, unit: UnitTemperature.fahrenheit)
        let celsius = fahrenheit.converted(to: .celsius)
        return celsius.value
    }
}
