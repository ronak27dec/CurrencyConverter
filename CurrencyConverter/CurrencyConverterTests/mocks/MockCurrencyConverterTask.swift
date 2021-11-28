//
//  MockCurrencyConverterTask.swift
//  CurrencyConverterTests
//
//  Created by Ronak on 28/11/21.
//

import Foundation
@testable import CurrencyConverter

class MockCurrencyConverterTask: CurrencyConverterServiceProtocol {
    var isSuccess: Bool = false

    func convertCurrency(from: String,
                         to: String,
                         amount: String,
                         onCompletion: @escaping (Result<Converter?, NetworkError>) -> Void) {
        if isSuccess {
            let converter = Converter(text: "100 INR = 1.332393 USD")
            onCompletion(.success(converter))
        } else {
            onCompletion(.failure(.networkError("Something went wrong")))
        }
    }
}
