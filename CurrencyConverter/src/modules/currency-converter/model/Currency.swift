//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Ronak on 25/11/21.
//

import Foundation

struct Currency: Decodable {
    var text: String?

    private enum CodingKeys: String, CodingKey {
        case text = "text"
    }
}

