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
    case fileServiceError(_ error: String)
}

extension NetworkError: Equatable {

    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
            case (.invalidURL, invalidURL): return true
            case (.parsingError, parsingError): return true
            case (.networkError, networkError): return true
            case (.genericError, genericError): return true
            case (.fileServiceError, fileServiceError): return true
            default: return false
        }
    }
}
