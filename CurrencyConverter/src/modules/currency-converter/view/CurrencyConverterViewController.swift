//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Ronak on 24/11/21.
//

import UIKit

final class CurrencyConverterViewController: UIViewController {

    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var sourceCurrencyTextField: UITextField!
    @IBOutlet var destinationCurrencyTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!

    private lazy var picker: UIPickerView = { UIPickerView() }()
    private var selectedTableViewTag = 0
    private lazy var viewModel: CurrencyConverterViewModel = { CurrencyConverterViewModel() }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIOnLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchCurrencies()
    }

    private func setupUIOnLoad() {
        picker.delegate = self
        picker.dataSource = self
        sourceCurrencyTextField.addTarget(self, action: #selector(showPicker(_:)), for: .touchDown)
        destinationCurrencyTextField.addTarget(self, action: #selector(showPicker(_:)), for: .touchDown)
    }

    @IBAction func convertCurrencyButtonClicked(_ sender: Any) {
        viewModel.bindDataOnSuccess = {[weak self] text in self?.updateUI(text)}
        viewModel.bindDataOnFailure = {[weak self] error in self?.updateUIOnFailure(error) }

        convertCurrency()
    }

    private func convertCurrency() {
        guard let sourceCurrency = sourceCurrencyTextField.text else {return}
        guard let targetCurrency = destinationCurrencyTextField.text else {return}
        guard let amount = amountTextField.text else {return}

        DispatchQueue.global(qos: .userInteractive).async {
            self.viewModel.convertCurrency(from: sourceCurrency,
                                           to: targetCurrency,
                                           amount: amount)
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
        present(alert, animated: true, completion: nil)
    }

    @objc private func showPicker(_ textField: UITextField) {
        if textField == sourceCurrencyTextField {
            selectedTableViewTag = 0
            sourceCurrencyTextField.inputView = picker
        } else {
            selectedTableViewTag = 1
            destinationCurrencyTextField.inputView = picker
        }
        hidePicker(textField)
    }

    func hidePicker(_ textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }

    @objc func action() {
        view.endEditing(true)
    }
}


extension CurrencyConverterViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let keys = viewModel.currencies?.currencies.map { return $0.key }
        guard let selectedKey = keys?[row] else {return}
        if selectedTableViewTag == 0 {
            sourceCurrencyTextField.text = selectedKey
        } else {
            destinationCurrencyTextField.text = selectedKey
        }
    }
}

extension CurrencyConverterViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        viewModel.currencies?.currencies.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let unwrappedCurrency = viewModel.currencies?.currencies else {return ""}
        let keys = unwrappedCurrency.map { return $0.key }
        let selectedKey = keys[row]
        let value = unwrappedCurrency[selectedKey] ?? ""
        return value + "-" + selectedKey
    }
}
