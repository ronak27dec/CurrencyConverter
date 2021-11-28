//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Ronak on 24/11/21.
//

import Foundation

final class CurrencyConverterViewModel {
    
    private var currencyConverterTask: CurrencyConverterServiceProtocol
    private var currencyFileTask: CurrencyFileServiceProtocol

    var currencies: Currencies?
    var bindDataOnFailure: ((NetworkError?) -> Void) = {_ in }
    var bindDataOnSuccess: ((String) -> Void) = {_ in }
    
    init(currencyConverterTask: CurrencyConverterServiceProtocol = CurrencyConverterTask(),
         currencyFileTask: CurrencyFileServiceProtocol = FetchCurrencyFileTask()) {
        self.currencyConverterTask = currencyConverterTask
        self.currencyFileTask = currencyFileTask
    }
    
    func convertCurrency(from sourceCurrency: String,
                         to targetCurrency: String,
                         amount: String) {
        currencyConverterTask.convertCurrency(from: sourceCurrency,
                                              to: targetCurrency,
                                              amount: amount) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let currencyModel):
                        guard let unwrappedText = currencyModel?.text else {
                            self?.bindDataOnFailure(.genericError("No text data found"))
                            return
                        }
                        self?.bindDataOnSuccess(unwrappedText)

                    case .failure(let error):
                        self?.bindDataOnFailure(error)
                }
            }
        }
    }

    func fetchCurrencies() {
        currencyFileTask.fetchCurrenciesSynchronously { result in
            switch result {
                case .success(let currencies):
                    self.currencies = currencies

                case .failure(let error):
                    print("Fetch Symbol Failed with error: \(error)")
            }
        }
    }

}
