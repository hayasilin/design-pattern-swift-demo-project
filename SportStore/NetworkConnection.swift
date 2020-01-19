//
//  NetworkConnection.swift
//  SportStore
//
//  Created by KuanWei on 2020/1/19.
//  Copyright © 2020 Kuan-Wei. All rights reserved.
//

import Foundation

class NetworkConnection {

    private let stockData: [String: Int] = [
        "Kayak": 10,
        "Lifejacket": 14,
        "Soccer Ball": 32,
        "Corner Flags": 1,
        "Stadium": 4,
        "Thinking Cap": 8,
        "Unsteady Chair": 3,
        "Human Chess Board": 2,
        "Bling-Bling King": 4
    ]

    func getStockLevel(name: String, completion: (() -> Void)) {
        Thread.sleep(forTimeInterval: Double(arc4random() % 2))
        completion()
    }
}
