//
//  CurrencyConverterTask.swift
//  CurrencyConverter
//
//  Created by Ronak on 25/11/21.
//

import Foundation

final class CurrencyConverterTask: CurrencyConverterServiceProtocol {
    private var service: NetworkServiceable
    private var task: URLSessionTask?
    
    init(with service: NetworkServiceable = NetworkService()) {
        self.service = service
    }
    
    func convertCurrency(from sourceCurrency: String,
                         to targetCurrency: String,
                         amount: String, onCompletion: @escaping (Result<Converter?, NetworkError>) -> Void) {
        cancel()
        task = service.dispatch(.currencyConverter(sourceCurrency: sourceCurrency,
                                                   targetCurrency: targetCurrency,
                                                   amount: amount),
                                onCompletion: {[weak self] result in
                                    switch result {
                                        case .success(let converterData):
                                            self?.currencyConverterResponseHandlerOnSuccess(converterData,
                                                                                            onCompletion: onCompletion)
                                            
                                        case .failure(let error):
                                            self?.currencyConverterResponseHandlerOnFailure(error,
                                                                                            onCompletion: onCompletion)
                                    }
                                })
    }
    
    private func currencyConverterResponseHandlerOnSuccess(_ converterData: Data?,
                                                           onCompletion: @escaping (Result<Converter?, NetworkError>) -> Void) {
        guard let unwrappedData = converterData else {
            onCompletion(.failure(.networkError("NETWORK ERROR: No Data")))
            return
        }
        let parser = Parser(data: unwrappedData)
        do {
            let model = try parser.parse(for: Converter.self)
            onCompletion(.success(model))
        }
        catch(let ex) {
            onCompletion(.failure(.parsingError("PARSING ERROR: " + ex.localizedDescription)))
        }
    }

    private func currencyConverterResponseHandlerOnFailure(_ error: NetworkError,
                                                           onCompletion: @escaping (Result<Converter?, NetworkError>) -> Void) {
        onCompletion(.failure(.networkError(error.localizedDescription)))
    }

    private func cancel() {
        guard let task = task else {return}
        task.cancel()
        self.task = nil
    }
}
