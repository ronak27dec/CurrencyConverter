//
//  MockCurrencyFileTask.swift
//  CurrencyConverterTests
//
//  Created by Ronak on 28/11/21.
//

import Foundation
@testable import CurrencyConverter

class MockCurrencyFileTask: CurrencyFileServiceProtocol {
    var isSuccess: Bool = false

    func fetchCurrenciesSynchronously(onCompletion: @escaping (Result<Currencies?, NetworkError>) -> Void) {
        if isSuccess {
            let currencies = Currencies(currencies: ["INR": "Indian National Rupees"])
            onCompletion(.success(currencies))
        } else {
            onCompletion(.failure(.networkError("Something went wrong")))
        }
    }
}
