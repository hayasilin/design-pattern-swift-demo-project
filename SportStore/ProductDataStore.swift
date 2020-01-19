//
//  ProductDataStore.swift
//  SportStore
//
//  Created by KuanWei on 2020/1/19.
//  Copyright © 2020 Kuan-Wei. All rights reserved.
//

import Foundation

final class ProductDataStore {
    var callback: ((Product) -> Void)?
    lazy var products: [Product] = self.loadData()

    private var productData: [Product] = [
        ProductComposite(name: "Running Pack", description: "Complete running outfit", category: "Running", stockLevel: 10, products: [
            Product(name: "Shirt", description: "Running shirt", category: "Running", price: 42, stockLevel: 10),
            Product(name: "Shorts", description: "Running shorts", category: "Running", price: 30, stockLevel: 10),
            Product(name: "Shoes", description: "Running shoes", category: "Running", price: 120, stockLevel: 10),
            Product(name: "Headgear", description: "Hat, etc", category: "Running", price: 10, stockLevel: 10),
            Product(name: "Sunglasses", description: "Glasses", category: "Running", price: 10, stockLevel: 10)]),
        Product.createProduct(name: "Kayak", description: "A boat for one person", category: "Watersports", price: 275.0, stockLevel: 10),
        Product.createProduct(name: "Lifejacket", description: "Protective and fashionable", category: "Watersports", price: 48.95, stockLevel: 14),
        Product.createProduct(name: "Soccer Ball", description: "FIFA-approved size and weight", category: "Soccer", price: 19.5, stockLevel: 32),
        Product.createProduct(name: "Corner Flags", description: "Give your playing field a professional touch", category: "Soccer", price: 34.95, stockLevel: 1),
        Product.createProduct(name: "Stadium", description: "Flat-packed 35,000-seat stadium", category: "Soccer", price: 79500.0, stockLevel: 4),
        Product.createProduct(name: "Thinking Cap", description: "Improve your brain efficiency by 75%", category: "Chess", price: 16.0, stockLevel: 8),
        Product.createProduct(name: "Unsteady Chair", description: "Secretly give your opponent a disadvantage", category: "Chess", price: 29.95, stockLevel: 3),
        Product.createProduct(name: "Human Chess Board", description: "A fun game for the family", category: "Chess", price: 75.0, stockLevel: 2),
        Product.createProduct(name: "Bling-Bling King", description: "Gold-plated, diamond-studded King", category: "Chess", price: 1200.0, stockLevel: 4)
    ]


    func loadData() -> [Product] {
        var products = [Product]()
        for product in productData {
            var p: Product = LowStockIncreaseDecorator(product: product)
            if p.category == "Soccer" {
                p = SoccerDecreaseDecorator(product: p)
            }

            StockServerFactory.getStockServer().getStockLevel(product: p.name) { (name, stockLevel) in
                p.stockLevel = stockLevel
                if self.callback != nil {
                    self.callback?(product)
                }
            }

            products.append(product)
        }
        return products
    }
}
