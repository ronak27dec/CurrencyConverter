//
//  FileManager+JSON.swift
//  CurrencyConverter
//
//  Created by Ronak on 27/11/21.
//

import Foundation

extension FileManager {

    static func readJson(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: FileService.self)
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch (let ex){
                print("FILE ERROR: \(ex.localizedDescription)")
            }
        }
        return nil
    }
}
