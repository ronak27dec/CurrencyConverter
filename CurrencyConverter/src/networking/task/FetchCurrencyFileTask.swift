//
//  FetchCurrencyFileTask.swift
//  CurrencyConverter
//
//  Created by Ronak on 27/11/21.
//

import Foundation

final class FetchCurrencyFileTask: CurrencyFileServiceProtocol {
    private var fileService: FileService
    
    init(with fileService: FileService = FileService()) {
        self.fileService = fileService
    }
    
    func fetchCurrenciesSynchronously(onCompletion: @escaping (Result<Currencies?, NetworkError>) -> Void) {
        fileService.fetch(fileName: "currencies") { result in
            switch result {
                case .success(let currencyData):
                    currencyHandlerOnSuccess(currencyData, onCompletion: onCompletion)
                    
                case .failure(let error):
                    currencyHandlerOnFailure(error, onCompletion: onCompletion)
            }
        }
    }
    
    func currencyHandlerOnSuccess(_ currencyData: Data?,
                                  onCompletion: @escaping (Result<Currencies?, NetworkError>) -> Void) {
        guard let unwrappedData = currencyData else {
            onCompletion(.failure(.networkError("NO Data")))
            return
        }
        
        do {
            let parser = Parser(data: unwrappedData)
            let model = try parser.parse(for: Currencies.self)
            onCompletion(.success(model))
        }
        catch (let ex) {
            onCompletion(.failure(.parsingError("Parsing Error: \(ex)")))
        }
    }
    
    func currencyHandlerOnFailure(_ error: NetworkError,
                                  onCompletion: @escaping (Result<Currencies?, NetworkError>) -> Void) {
        onCompletion(.failure(.fileServiceError(error.localizedDescription)))
    }
}
