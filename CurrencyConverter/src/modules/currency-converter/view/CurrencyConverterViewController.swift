//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Ronak on 24/11/21.
//

import UIKit

class CurrencyConverterViewController: UIViewController {

    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var sourceCurrencyTextField: UITextField!
    @IBOutlet var destinationCurrencyTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!

    private lazy var viewModel: CurrencyConverterViewModel = { CurrencyConverterViewModel() }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIOnLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchCurrencySymbolSilently()
    }

    private func setupUIOnLoad() {
        sourceCurrencyTextField.addTarget(self, action: #selector(navigateToSymbolView), for: .touchDown)
        destinationCurrencyTextField.addTarget(self, action: #selector(navigateToSymbolView), for: .touchDown)
    }

    @IBAction func convertCurrencyButtonClicked(_ sender: Any) {
        viewModel.bindCurrencyDataOnSuccess = {[weak self] text in self?.updateUI(text)}
        viewModel.bindCurrencyDataOnFailure = {[weak self] error in self?.updateUIOnFailure(error) }

        convertCurrency()
    }

    private func convertCurrency() {
        guard let sourceCurrency = sourceCurrencyTextField.text else {return}
        guard let targetCurrency = destinationCurrencyTextField.text else {return}
        guard let amount = amountTextField.text else {return}

        DispatchQueue.global(qos: .userInteractive).async {
            self.viewModel.convertCurrency(from: sourceCurrency, to: targetCurrency, amount: amount)
        }
    }

    func updateUI(_ text: String) {
        resultLabel.text = text
    }

    func updateUIOnFailure(_ error: NetworkError?) {
        print("ERROR: \(String(describing: error?.localizedDescription))")

        showErrorAlert()
    }

    private func showErrorAlert() {
        let alert = UIAlertController(title: "Something went wrong",
                                      message: "Please try again later",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.present(self, animated: true, completion: nil)
    }

    @objc private func navigateToSymbolView() {
    }
}
