//
//  FileService.swift
//  CurrencyConverter
//
//  Created by Ronak on 27/11/21.
//

import Foundation

final class FileService {

    func fetch(fileName: String, onCompletion: (Result<Data?, NetworkError>) -> Void) {
        guard let data = FileManager.readJson(forResource: "currencies") else {
            onCompletion(.failure(.fileServiceError("No File data")))
            return
        }
        onCompletion(.success(data))
    }
}
