//
//  CurrencyConverterTask.swift
//  CurrencyConverter
//
//  Created by Ronak on 25/11/21.
//

import Foundation

final class CurrencyConverterTask: CurrencyServiceProtocol {
    private var service: NetworkService
    private var task: URLSessionTask?
    
    init(with service: NetworkService = NetworkService()) {
        self.service = service
    }
    
    func convertCurrency(from sourceCurrency: String,
                         to targetCurrency: String,
                         amount: String, onCompletion: @escaping (Result<Currency?, NetworkError>) -> Void) {
        cancel()
        task = service.dispatch(.currencyConverter(sourceCurrency: sourceCurrency,
                                                   targetCurrency: targetCurrency,
                                                   amount: amount),
                                onCompletion: {[weak self] result in
                                    switch result {
                                        case .success(let currencyData):
                                            self?.currencyResponseHandlerOnSuccess(currencyData,
                                                                                   onCompletion: onCompletion)
                                            
                                        case .failure(let error):
                                            self?.currencyResponseHandlerOnFailure(error,
                                                                                   onCompletion: onCompletion)
                                    }
                                })
    }
    
    private func currencyResponseHandlerOnSuccess(_ responseData: Data?,
                                                  onCompletion: @escaping (Result<Currency?, NetworkError>) -> Void) {
        guard let unwrappedData = responseData else {
            onCompletion(.failure(.networkError("NETWORK ERROR: No Data")))
            return
        }
        let parser = Parser(data: unwrappedData)
        do {
            let model = try parser.parse(for: Currency.self)
            onCompletion(.success(model))
        }
        catch(let ex) {
            onCompletion(.failure(.parsingError("PARSING ERROR: " + ex.localizedDescription)))
        }
    }
    
    private func currencyResponseHandlerOnFailure(_ error: NetworkError,
                                                  onCompletion: @escaping (Result<Currency?, NetworkError>) -> Void) {
        onCompletion(.failure(.networkError(error.localizedDescription)))
    }
    
    private func cancel() {
        guard let task = task else {return}
        task.cancel()
        self.task = nil
    }
}
