//
//  Parser.swift
//  CurrencyConverter
//
//  Created by Ronak on 25/11/21.
//

import Foundation

struct Parser {
    private var data: Data

    init(data: Data) {
        self.data = data
    }

    func parse<T: Decodable>(for type: T.Type) throws -> T? {
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: data)
            return model
        } catch(let ex) {
            print("ERROR: Parsing Exception - \(ex)")
            throw NetworkError.parsingError("Parsing error" + ex.localizedDescription)
        }
    }
}
