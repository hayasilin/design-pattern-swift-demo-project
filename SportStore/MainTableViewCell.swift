//
//  MainTableViewCell.swift
//  SportStore
//
//  Created by KuanWei on 2018/7/1.
//  Copyright © 2018年 Kuan-Wei. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var stockField: UITextField!
    
    var product: Product?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        NotificationCenter.default.addObserver(self, selector: #selector(handleStockLevelUpdate(notification:)), name: NSNotification.Name(rawValue: "stockUpdate"), object: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc func handleStockLevelUpdate(notification: Notification) {
        if let updatedProduct = notification.object as? Product {
            if updatedProduct.name == self.product?.name {
                DispatchQueue.main.async {
                    self.stockStepper.value = Double(updatedProduct.stockLevel)
                    self.stockField.text = String(updatedProduct.stockLevel)
                }
            }
        }
    }
}
