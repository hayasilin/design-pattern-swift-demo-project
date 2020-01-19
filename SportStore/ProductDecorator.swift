//
//  ProductDecorator.swift
//  SportStore
//
//  Created by KuanWei on 2020/1/19.
//  Copyright © 2020 Kuan-Wei. All rights reserved.
//

import Foundation

class ProductDecorator: Product {
    let wrappedProduct: Product

    required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        fatalError("Not supported")
    }

    init(product: Product) {
        self.wrappedProduct = product
        super.init(name: product.name, description: product.productDescription, category: product.category, price: product.price, stockLevel: product.stockLevel)
    }
}

class LowStockIncreaseDecorator: ProductDecorator {
    override var price: Double {
        var price = wrappedProduct.price
        if stockLevel <= 4 {
            price = price * 1.5
        }
        return price
    }
}

class SoccerDecreaseDecorator: ProductDecorator {
    override var price: Double {
        return super.wrappedProduct.price * 0.5
    }
}
