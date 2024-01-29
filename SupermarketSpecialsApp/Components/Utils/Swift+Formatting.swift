//
//  Swift+Formatting.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 9/10/23.
//

import Foundation

enum Formatters {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.usesGroupingSeparator = true
        formatter.generatesDecimalNumbers = true
        formatter.currencySymbol = "$"
        return formatter
    }
}

extension String {
    func asDecimalFormat() -> Double? {
        Formatters.currency.number(from: self) as? Double
    }
}

extension Double {
    func asCurrencyString() -> String {
        Formatters.currency.string(from: self as NSNumber) ?? ""
    }
}
