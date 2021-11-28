//
//  CurrencyConverterServiceProtocol.swift
//  CurrencyConverter
//
//  Created by Ronak on 25/11/21.
//

import Foundation

protocol CurrencyConverterServiceProtocol {
    func convertCurrency(from: String,
                         to: String,
                         amount: String,
                         onCompletion: @escaping (Result<Converter?, NetworkError>) -> Void)
}
