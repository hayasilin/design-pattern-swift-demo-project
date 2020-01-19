//
//  StockTotalFacade.swift
//  SportStore
//
//  Created by KuanWei on 2020/1/19.
//  Copyright © 2020 Kuan-Wei. All rights reserved.
//

import Foundation

class StockTotalFacade {
    enum Currency {
        case usd
        case gbp
        case eur
    }

    class func formatCurrencyAmount(amount: Double, currency: Currency) -> String? {
        var stfCurrency: StockTotalFactory.Currency
        switch currency {
        case .eur:
            stfCurrency = StockTotalFactory.Currency.eur
        case .gbp:
            stfCurrency = StockTotalFactory.Currency.gbp
        case .usd:
            stfCurrency = StockTotalFactory.Currency.usd
        }

        let factory = StockTotalFactory.getFactory(currency: stfCurrency)
        let totalAmount = factory.converter?.convertTotal(total: amount)
        if totalAmount != nil {
            let formattedValue = factory.formatter?.formatTotal(total: totalAmount!)
            if formattedValue != nil {
                return formattedValue
            }
        }
        return nil
    }
}
