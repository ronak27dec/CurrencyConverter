//
//  CurrencyConverterViewModelTest.swift
//  CurrencyConverterTests
//
//  Created by Ronak on 28/11/21.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterViewModelTest: XCTestCase {

    var sut: CurrencyConverterViewModel!
    var mockCurrencyConverterTask: MockCurrencyConverterTask!
    var mockCurrencyFileTask: MockCurrencyFileTask!

    override func setUp() {
        super.setUp()
        mockCurrencyConverterTask = MockCurrencyConverterTask()
        mockCurrencyFileTask = MockCurrencyFileTask()
        sut = CurrencyConverterViewModel(currencyConverterTask: mockCurrencyConverterTask,
                                         currencyFileTask: mockCurrencyFileTask)
    }

    override func tearDown() {
        mockCurrencyConverterTask = nil
        mockCurrencyFileTask = nil
        sut = nil
        super.tearDown()
    }

    func testConvertCurrency_SUCCESS() {
        let expectation = XCTestExpectation(description: "Convert currency with SUCCESS")
        mockCurrencyConverterTask.isSuccess = true

        sut.bindDataOnSuccess = { model in
            expectation.fulfill()
            XCTAssertEqual(model, "100 INR = 1.332393 USD")
        }

        sut.convertCurrency(from: "INR", to: "USD", amount: "100")
        wait(for: [expectation], timeout: 5.0)
    }

    func testConvertCurrency_FAILURE() {
        let expectation = XCTestExpectation(description: "Convert currency FAILURE")
        mockCurrencyConverterTask.isSuccess = false

        sut.bindDataOnFailure = { error in
            expectation.fulfill()
            XCTAssertEqual(error, NetworkError.networkError("Something went wrong"))
        }

        sut.convertCurrency(from: "INR", to: "USD", amount: "100")
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchCurrencies_SUCCESS() {
        mockCurrencyFileTask.isSuccess = true

        sut.fetchCurrencies()

        XCTAssertTrue(sut.currencies?.currencies.keys.count == 1)
        XCTAssertTrue(sut.currencies?.currencies["INR"] == "Indian National Rupees")
    }

    func testFetchCurrencies_FAILURE() {
        sut.currencies?.currencies.removeAll()
        mockCurrencyFileTask.isSuccess = false

        sut.fetchCurrencies()

        XCTAssertNil(sut.currencies?.currencies)
    }
}
