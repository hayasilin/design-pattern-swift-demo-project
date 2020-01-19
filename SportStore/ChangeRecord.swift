//
//  ChangeRecord.swift
//  SportStore
//
//  Created by KuanWei on 2020/1/19.
//  Copyright © 2020 Kuan-Wei. All rights reserved.
//

import Foundation

class ChangeRecord {
    private let outerTag: String
    private let productName: String
    private let catName: String
    private let innerTag: String
    private let value: String

    init(outer: String, name: String, category: String, inner: String, value: String) {
        self.outerTag = outer
        self.productName = name
        self.catName = category
        self.innerTag = inner
        self.value = value
    }

    var description: String {
        return "<\(outerTag)><\(innerTag) name=\(productName)>" + " category=<\(catName)>\(value)<\(innerTag)><\(outerTag)>"
    }
}
