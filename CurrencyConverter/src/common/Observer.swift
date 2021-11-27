//
//  Observer.swift
//  CurrencyConverter
//
//  Created by Ronak on 24/11/21.
//

import Foundation

class Observer<T> {

    typealias CompletionHandler = ((T) -> Void)

    private var observers: [String: CompletionHandler] = [:]
    var value: T { didSet { notify()} }


    init(value: T) {
        self.value = value
    }

    public func addObserver(_ observer: NSObject,
                            completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }

    public func addAndNotify(observer: NSObject,
                             completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }

    private func notify() {
        observers.forEach({ $0.value(value) })
    }

    deinit {
        observers.removeAll()
    }
}
