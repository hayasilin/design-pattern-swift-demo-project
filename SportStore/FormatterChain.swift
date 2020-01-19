//
//  FormatterChain.swift
//  SportStore
//
//  Created by KuanWei on 2020/1/19.
//  Copyright © 2020 Kuan-Wei. All rights reserved.
//

import Foundation
import UIKit

class CellFormatter {
    var nextLink: CellFormatter?

    func formatCell(cell: MainTableViewCell) {
        nextLink?.formatCell(cell: cell)
    }

    class func createChain() -> CellFormatter {
        let formatter = ChessFormatter()
        formatter.nextLink = WatersportsFormatter()
        formatter.nextLink?.nextLink = DefaultFormatter()
        return formatter
    }
}

class ChessFormatter: CellFormatter {
    override func formatCell(cell: MainTableViewCell) {
        if cell.product?.category == "Chess" {
            cell.backgroundColor = .lightGray
        } else {
            super.formatCell(cell: cell)
        }
    }
}

class WatersportsFormatter: CellFormatter {
    override func formatCell(cell: MainTableViewCell) {
        if cell.product?.category == "Watersports" {
            cell.backgroundColor = .green
        } else {
            super.formatCell(cell: cell)
        }
    }
}

class DefaultFormatter: CellFormatter {
    override func formatCell(cell: MainTableViewCell) {
        cell.backgroundColor = .yellow
    }
}
