//
//  Proxy.swift
//  SportStore
//
//  Created by KuanWei on 2020/1/19.
//  Copyright © 2020 Kuan-Wei. All rights reserved.
//

import Foundation

protocol StockServer {
    func getStockLevel(product: String, callback: (String, Int) -> Void)
}

class StockServerProxy: StockServer {
    func getStockLevel(product: String, callback: (String, Int) -> Void) {
        // Change value here as a proxy
        callback("", 7)
    }
}

class StockServerFactory {
    private class var server: StockServer {
        struct singletonWrapper {
            static let singleton: StockServer = StockServerProxy()
        }
        return singletonWrapper.singleton
    }

    class func getStockServer() -> StockServer {
        return server
    }
}
