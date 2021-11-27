//
//  GenericTableViewDataSource.swift
//  CurrencyConverter
//
//  Created by Ronak on 24/11/21.
//

import Foundation

class GenericDataSource<T> : NSObject {
    var data: Observer<[T]> = Observer(value: [])
}
