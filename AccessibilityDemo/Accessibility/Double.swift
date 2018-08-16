//
//  Double.swift
//  Accessibility
//
//  Created by Marco Salazar on 8/13/18.
//  Copyright © 2018 Scotiabank Peru. All rights reserved.
//

import Foundation

extension Double {
    var currencyFormat: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = false
        formatter.locale = Locale(identifier: "es_PE_POSIX")
        return formatter.string(from: NSNumber(value: self))!
    }
    var accessiblityFormat: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyPlural
        formatter.usesGroupingSeparator = false
        formatter.locale = Locale(identifier: "es_PE_POSIX")
        return formatter.string(from: NSNumber(value: self))!
    }
}
