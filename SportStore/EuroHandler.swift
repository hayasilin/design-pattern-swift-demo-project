//
//  EuroHandler.swift
//  SportStore
//
//  Created by KuanWei on 2020/1/19.
//  Copyright © 2020 Kuan-Wei. All rights reserved.
//

import Foundation

class EuroHandler {
    func getDisplayString(amount: Double) -> String {
        let formatted = Utils.currencyStringFromNumber(number: amount)
        return "Euro:\(formatted)"
    }

    func getCurrencyAmount(amount: Double) -> Double {
        return 0.76164 * amount
    }
}
