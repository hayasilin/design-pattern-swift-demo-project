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
    
    var products = [
        ("Kayak", "A boat for one person", "Watersports", 275.0, 10),
        ("Lifejacket", "Protective and fashionable", "Watersports", 48.95, 14),
        ("Soccer Ball", "FIFA-approved size and weight", "Soccer", 19.5, 32),
        ("Corner Flags", "Give your playing field a professional touch", "Soccer", 34.95, 1),
        ("Stadium", "Flat-packed 35,000-seat stadium", "Soccer", 79500.0, 4),
        ("Thinking Cap", "Improve your brain efficiency by 75%", "Chess", 16.0, 8),
        ("Unsteady Chair", "Secretly give your opponent a disadvantage", "Chess", 29.95, 3),
        ("Human Chess Board", "A fun game for the family", "Chess", 75.0, 2),
        ("Bling-Bling King", "Gold-plated, diamond-studded King", "Chess", 1200.0, 4)
    ];

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: String(describing: MainTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        displayStockTotal()
    }

    func displayStockTotal() {
        let stockTotal = products.reduce(0, { (total, product) -> Int in return total + product.4 });
        totalStockLabel.text = "\(stockTotal) Products in Stock";
    }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell else {
            fatalError("")
        }

        let product = products[indexPath.row];

        cell.productId = indexPath.row;
        cell.titleLabel.text = product.0;
        cell.detailLabel.text = product.1;
        cell.stockStepper.value = Double(product.4);
        cell.stockStepper.addTarget(self, action: #selector(stockLevelDidChange(sender:)), for: .valueChanged)
        cell.stockField.text = String(product.4);

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
                    if let id = cell.productId {
                        var newStockLevel:Int?;

                        if let stepper = sender as? UIStepper {
                            newStockLevel = Int(stepper.value);
                        }
                        else if let textfield = sender as? UITextField {
                            if let newValue = textfield.text?.count {
                                newStockLevel = newValue;
                            }
                        }

                        if let level = newStockLevel {
                            products[id].4 = level;
                            cell.stockStepper.value = Double(level);
                            cell.stockField.text = String(level);
                        }
                    }
                    break;
                }
            }
            displayStockTotal();
        }
    }
}
