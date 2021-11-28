//
//  Currencies.swift
//  CurrencyConverter
//
//  Created by Ronak on 27/11/21.
//

import Foundation

struct Currencies: Decodable {
    var currencies: [String: String]

    private enum CodingKeys: String, CodingKey {
        case currencies = "currencies"
    }
}
