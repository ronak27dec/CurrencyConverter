//
//  CurrencyServiceProtocol.swift
//  CurrencyConverter
//
//  Created by Ronak on 25/11/21.
//

import Foundation

protocol CurrencyServiceProtocol {
    func convertCurrency(from: String,
                         to: String,
                         amount: String,
                         onCompletion: @escaping (Result<Currency?, NetworkError>) -> Void)
}
