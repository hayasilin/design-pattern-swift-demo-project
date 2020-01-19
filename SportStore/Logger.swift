//
//  Logger.swift
//  SportStore
//
//  Created by KuanWei on 2020/1/18.
//  Copyright © 2020 Kuan-Wei. All rights reserved.
//

import Foundation

let productLogger = Logger<Product>(callback: { p in
    print("Change: \(p.name) \(p.stockLevel) item in stock")

    var builder = ChangeRecordBuilder()
    builder.productName = p.name
    builder.category = p.category
    builder.value = String(p.stockLevel)
    builder.outerTag = "StockChange"

    var changeRecord = builder.changeRecord
    if let changeRecord = changeRecord {
        print(changeRecord.description)
    }
})

final class Logger<T> where T: NSObject, T: NSCopying {
    var dataItems: [T] = []
    var callback: (T) -> Void
    var arrayQ = DispatchQueue(label: "arrayQ")
    var callbackQ = DispatchQueue(label: "callbackQ")

    init(callback: @escaping (T) -> Void, protect: Bool = true) {
        self.callback = callback
        if protect {
            self.callback = { (item: T) in
                self.callbackQ.sync {
                    callback(item)
                }
            }
        }
    }

    func logItem(item: T) {
        arrayQ.async(flags: .barrier) { [weak self] in
            self?.dataItems.append(item.copy() as! T)
            self?.callback(item)
        }
    }

    func processItems(callback: (T) -> Void) {
        arrayQ.sync {
            for item in dataItems {
                callback(item)
            }
        }
    }
}
