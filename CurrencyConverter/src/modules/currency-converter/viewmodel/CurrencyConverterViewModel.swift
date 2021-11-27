//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Ronak on 24/11/21.
//

import Foundation

class CurrencyConverterViewModel {
    
    private var currencyServiceTask: CurrencyServiceProtocol
    private var currencySymbolTask: CurrencySymbolServiceProtocol
    private var symbols: CurrencySymbol?
    var bindCurrencyDataOnFailure: ((NetworkError?) -> Void) = {_ in }
    var bindCurrencyDataOnSuccess: ((String) -> Void) = {_ in }
    
    init(currencyServiceTask: CurrencyServiceProtocol = CurrencyConverterTask(),
         currencySymbolTask: CurrencySymbolServiceProtocol = CurrencySymbolTask()) {
        self.currencyServiceTask = currencyServiceTask
        self.currencySymbolTask = currencySymbolTask
    }
    
    func convertCurrency(from sourceCurrency: String,
                         to targetCurrency: String,
                         amount: String) {

        currencyServiceTask.convertCurrency(from: sourceCurrency,
                                            to: targetCurrency,
                                            amount: amount) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let currencyModel):
                        guard let unwrappedText = currencyModel?.text else {return}
                        self.bindCurrencyDataOnSuccess(unwrappedText)

                    case .failure(let error):
                        self.bindCurrencyDataOnFailure(error)
                }
            }
        }
    }

    func fetchCurrencySymbolSilently() {
        currencySymbolTask.fetchCurrencySymbols { result in
            switch result {
                case .success(let symbols):
                    self.symbols = symbols

                case .failure(let error):
                    print("Fetch Symbol Failed with error: \(error)")
            }
        }
    }
}
