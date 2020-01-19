//
//  Product.swift
//  SportStore
//
//  Created by KuanWei on 2020/1/18.
//  Copyright © 2020 Kuan-Wei. All rights reserved.
//

import Foundation

enum UpsellOpportunities {
    case swimmingLessons
    case mapOfLakes
    case soccerVideos
}

class Product: NSObject, NSCopying {
    private(set) var name: String
    private(set) var productDescription: String
    private(set) var category: String
    var salesTaxRate: Double = 0.2

    private(set) var price: Double {
        get {
            return priceBackingValue
        }
        set {
            priceBackingValue = max(1, newValue)
        }
    }

    var stockLevel: Int {
        get {
            return stockLevelBackingValue
        }
        set {
            stockLevelBackingValue = max(0, newValue)
        }
    }

    var stockValue: Double {
        get {
            return (price * (1 + salesTaxRate)) * Double(stockLevel)
        }
    }

    private var stockLevelBackingValue: Int = 0
    private var priceBackingValue: Double = 0

    required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        self.name = name
        self.productDescription = description
        self.category = category

        super.init()

        self.price = price
        self.stockLevel = stockLevel
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return Product(name: self.name, description: self.productDescription, category: self.category, price: self.price, stockLevel: self.stockLevel)
    }

    var upsells: [UpsellOpportunities] {
        get {
            return [UpsellOpportunities]()
        }
    }

    class func createProduct(name: String, description: String, category: String, price: Double, stockLevel: Int) -> Product {
        var productType: Product.Type

        switch category {
        case "Watersports":
            productType = WatersportsProduct.self
        case "Soccer":
            productType = SoccerProduct.self
        default:
            productType = Product.self
        }

        return productType.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
    }
}

class WatersportsProduct: Product {
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
        salesTaxRate = 0.10
    }

    override var upsells: [UpsellOpportunities] {
        return [.swimmingLessons, .mapOfLakes]
    }
}

class SoccerProduct: Product {
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
        salesTaxRate = 0.25
    }

    override var upsells: [UpsellOpportunities] {
        return [.soccerVideos]
    }
}

class ProductComposite: Product {
    private let products: [Product]

    required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        fatalError()
    }

    init(name: String, description: String, category: String, stockLevel: Int, products: [Product]) {
        self.products = products
        super.init(name: name, description: description, category: category, price: 0, stockLevel: stockLevel)
    }

    override var price: Double {
        get {
            return products.reduce(0) { (total, product) in
                return total + product.price
            }
        }
    }
}
