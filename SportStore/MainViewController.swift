//
//  MainViewController.swift
//  SportStore
//
//  Created by KuanWei on 2018/7/1.
//  Copyright © 2018年 Kuan-Wei. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalStockLabel: UILabel!
    var productStore = ProductDataStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: String(describing: MainTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        displayStockTotal()
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == .motionShake {
            print("Shake motion detected")
            undoManager?.undo()
        }
    }

    func displayStockTotal() {
        let finalTotals: (Int, Double) = productStore.products.reduce((0, 0.0)) { (totals, product) -> (Int, Double) in
            return (
                totals.0 + product.stockLevel,
                totals.1 + product.stockValue
            )
        }

        let formatted = StockTotalFacade.formatCurrencyAmount(amount: finalTotals.1, currency: StockTotalFacade.Currency.eur)

        totalStockLabel.text = "\(finalTotals.0) Products in Stock." + "Total value: \(String(describing: formatted))"
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productStore.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }

        let product = productStore.products[indexPath.row]
        cell.product = productStore.products[indexPath.row]
        cell.titleLabel.text = product.name
        cell.detailLabel.text = product.productDescription
        cell.stockStepper.addTarget(self, action: #selector(stockLevelDidChange(sender:)), for: .valueChanged)
        cell.stockStepper.value = Double(product.stockLevel)
        cell.stockField.text = String(product.stockLevel)

        CellFormatter.createChain().formatCell(cell: cell)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    @objc func stockLevelDidChange(sender: AnyObject) {
        if var currentCell = sender as? UIView {
            while (true) {
                currentCell = currentCell.superview!;
                if let cell = currentCell as? MainTableViewCell {
                    if let product = cell.product {

//                        let dict = [product.name: product.stockLevel]
                        undoManager?.registerUndo(withTarget: self, selector: #selector(resetState), object: nil)


                        if let stepper = sender as? UIStepper {
                            product.stockLevel = Int(stepper.value)
                        } else if let textfield = sender as? UITextField {
                            if let newValue = Int(textfield.text!) {
                                product.stockLevel = newValue
                            }
                        }

                        productLogger.logItem(item: product)
                    }
                    break
                }
            }
            displayStockTotal()
        }
    }

    @objc func resetState() {
        productStore.resetState()
    }

//    @objc func undoStockLevel(data: [String: Int]) {
//        let productName = data.keys.first
//        if productName != nil {
//            let stockLevel = data[productName!]
//            if stockLevel != nil {
//                for nproduct in productStore.products {
//                    if nproduct.name == productName {
//                        nproduct.stockLevel = stockLevel!
//                    }
//                }
//
//                updateStockLevel(name: productName!, level: stockLevel!)
//            }
//        }
//    }

    func updateStockLevel(name: String, level: Int) {
        for cell in self.tableView.visibleCells {
            if let pcell = cell as? MainTableViewCell {
                if pcell.product?.name == name {
                    pcell.stockStepper.value = Double(level);
                    pcell.stockField.text = String(level);
                }
            }
        }
        self.displayStockTotal();
    }
}
