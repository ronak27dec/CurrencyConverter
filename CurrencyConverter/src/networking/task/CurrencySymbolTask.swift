//
//  CurrencySymbolTask.swift
//  CurrencyConverter
//
//  Created by Ronak on 27/11/21.
//

import Foundation

final class CurrencySymbolTask: CurrencySymbolServiceProtocol {

    private var service: NetworkService
    private var task: URLSessionTask?

    init(with service: NetworkService = NetworkService()) {
        self.service = service
    }

    func fetchCurrencySymbols(onCompletion: @escaping (Result<CurrencySymbol?, NetworkError>) -> Void) {
        task = service.dispatch(.currencySymbol(), onCompletion: {[weak self] result in
            switch result {
                case .success(let symbolData):
                    self?.currencySymbolHandlerOnSuccess(symbolData, onCompletion: onCompletion)

                case .failure(let error):
                    self?.currencySymbolHandlerOnFailure(error, onCompletion: onCompletion)
            }
        })
    }

    private func currencySymbolHandlerOnSuccess(_ symbolData: Data?,
                                                onCompletion: @escaping (Result<CurrencySymbol?, NetworkError>) -> Void) {
        guard let unwrappedData = symbolData else {
            onCompletion(.failure(.networkError("NETWORK ERROR: No Data")))
            return
        }
        do {
            let parser = Parser(data: unwrappedData)
            let model = try parser.parse(for: CurrencySymbol.self)
            onCompletion(.success(model))
        }
        catch(let ex) {
            onCompletion(.failure(.parsingError("PARSING ERROR: " + ex.localizedDescription)))
        }
    }

    private func currencySymbolHandlerOnFailure(_ error: NetworkError,
                                                onCompletion: @escaping (Result<CurrencySymbol?, NetworkError>) -> Void) {
        onCompletion(.failure(.networkError("PARSING ERROR: " + error.localizedDescription)))
    }
}
