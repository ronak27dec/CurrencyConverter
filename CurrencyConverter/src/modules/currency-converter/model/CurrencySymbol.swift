//
//  CurrencySymbol.swift
//  CurrencyConverter
//
//  Created by Ronak on 27/11/21.
//

import Foundation

struct CurrencySymbol: Decodable {
    var symbol: Symbol?
}

struct Symbol: Decodable {
    var symbol: [String: String] = [:]
}
