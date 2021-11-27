//
//  CurrencySymbolServiceProtocol.swift
//  CurrencyConverter
//
//  Created by Ronak on 27/11/21.
//

import Foundation

protocol CurrencySymbolServiceProtocol {
    func fetchCurrencySymbols(onCompletion: @escaping (Result<CurrencySymbol?, NetworkError>) -> Void)
}
