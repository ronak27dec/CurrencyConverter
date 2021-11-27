//
//  Endpoint.swift
//  CurrencyConverter
//
//  Created by Ronak on 27/11/21.
//

import Foundation

struct Endpoint {
    let baseURL: String
    let path: String
    let queryItems: [URLQueryItem]
    let httpMethod: HTTPMethod
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
    
    static func currencyConverter(sourceCurrency: String,
                                  targetCurrency: String,
                                  amount: String) -> Endpoint {
        return Endpoint(baseURL: "v1.nocodeapi.com",
                        path: "/ronak/cx/WVNLyyxFoilWLWUf/rates/convert",
                        queryItems: [
                            URLQueryItem(name: "amount", value: amount),
                            URLQueryItem(name: "from", value: sourceCurrency),
                            URLQueryItem(name: "to", value: targetCurrency)
                        ],
                        httpMethod: HTTPMethod.get)
    }

    static func currencySymbol() -> Endpoint {
        return Endpoint(baseURL: "openexchangerates.org",
                        path: "/api/currencies.json",
                        queryItems: [],
                        httpMethod: HTTPMethod.get)
    }
}
