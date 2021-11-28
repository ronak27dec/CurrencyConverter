//
//  NetworkServiceable.swift
//  CurrencyConverterTests
//
//  Created by Ronak on 28/11/21.
//

import Foundation

protocol NetworkServiceable {
    func dispatch(_ endpoint: Endpoint,
                  onCompletion: @escaping (Result<Data, NetworkError>) -> Void) -> URLSessionTask?
}
