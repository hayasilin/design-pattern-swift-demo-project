//
//  StockValueFactories.swift
//  SportStore
//
//  Created by KuanWei on 2020/1/19.
//  Copyright © 2020 Kuan-Wei. All rights reserved.
//

import Foundation

class StockTotalFactory {
    enum Currency {
        case usd
        case gbp
    }

    var formatter: StockValueFormatter?
    var converter: StockValueConverter?

    class func getFactory(currency: Currency) -> StockTotalFactory {
        if currency == .usd {
            return DollarStockTotalFactory.sharedInstance
        } else {
            return PoundStockTotalFactory.sharedInstance
        }
    }
}

private class DollarStockTotalFactory: StockTotalFactory {
    private override init() {
        super.init()
        formatter = DollarStockValueFormatter()
        converter = DollarStockValueConverter()
    }

    class var sharedInstance: StockTotalFactory {
        get {
            struct SingletonWrapper {
                static let singleton = DollarStockTotalFactory()
            }
            return SingletonWrapper.singleton
        }
    }
}

private class PoundStockTotalFactory: StockTotalFactory {
    private override init() {
        super.init()
        formatter = PoundStockValueFormatter()
        converter = PoundStockValueConverter()
    }

    class var sharedInstance: StockTotalFactory {
        get {
            struct SingletonWrapper {
                static let singleton = PoundStockTotalFactory()
            }
            return SingletonWrapper.singleton
        }
    }
}
