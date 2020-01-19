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
        case eur
    }

    var formatter: StockValueFormatter?
    var converter: StockValueConverter?

    class func getFactory(currency: Currency) -> StockTotalFactory {
        switch currency {
        case .usd:
            return DollarStockTotalFactory.sharedInstance
        case .gbp:
            return PoundStockTotalFactory.sharedInstance
        case .eur:
            return EuroHandlerAdapter.sharedInstance
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

class EuroHandlerAdapter: StockTotalFactory, StockValueConverter, StockValueFormatter {
    private let handler: EuroHandler

    override init() {
        self.handler = EuroHandler()
        super.init()
        super.formatter = self
        super.converter = self
    }

    func formatTotal(total: Double) -> String {
        return handler.getDisplayString(amount: total)
    }

    func convertTotal(total: Double) -> Double {
        return handler.getCurrencyAmount(amount: total)
    }

    class var sharedInstance: EuroHandlerAdapter {
        get {
            struct SingletonWrapper {
                static let singleton = EuroHandlerAdapter()
            }
            return SingletonWrapper.singleton
        }
    }
}
