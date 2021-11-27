//
//  NetworkError.swift
//  CurrencyConverter
//
//  Created by Ronak on 25/11/21.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case parsingError(_ error: String)
    case networkError(_ error: String)
    case genericError(_ error: String)
}
