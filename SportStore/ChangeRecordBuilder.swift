//
//  ChangeRecordBuilder.swift
//  SportStore
//
//  Created by KuanWei on 2020/1/19.
//  Copyright © 2020 Kuan-Wei. All rights reserved.
//

import Foundation

class ChangeRecordBuilder {
    var outerTag: String
    var innerTag: String
    var productName: String?
    var category: String?
    var value: String?

    init() {
        self.outerTag = "change"
        self.innerTag = "product"
    }

    var changeRecord: ChangeRecord? {
        get {
            if productName != nil && category != nil && value != nil {
                return ChangeRecord(outer: outerTag, name: productName!, category: category!, inner: innerTag, value: value!)
            } else {
                return nil
            }
        }
    }
    
}
