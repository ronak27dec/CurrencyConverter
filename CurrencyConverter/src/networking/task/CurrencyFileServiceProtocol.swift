//
//  CurrencyFileServiceProtocol.swift
//  CurrencyConverter
//
//  Created by Ronak on 27/11/21.
//

import Foundation

protocol CurrencyFileServiceProtocol {
    func fetchCurrenciesSynchronously(onCompletion: @escaping (Result<Currencies?, NetworkError>) -> Void)
}
