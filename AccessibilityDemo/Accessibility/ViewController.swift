//
//  ViewController.swift
//  Accessibility
//
//  Created by Marco Salazar on 8/13/18.
//  Copyright © 2018 Scotiabank Peru. All rights reserved.
//

import UIKit

final class ViewController: UITableViewController {

    private let items = BillModel.items
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BillModel.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath) as? NormalCell else {
            assertionFailure("Invalid data")
            return UITableViewCell()
        }
        cell.configure(with: items[indexPath.row])
        return cell
    }

}


final class NormalCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var billNumber: UILabel!
    @IBOutlet weak var expirationDate: UILabel!
    @IBOutlet weak var status: UIImageView!

    func configure(with item: BillModel) {
        icon.image = item.icon
        name.text = item.name
        amount.text = "Monto \(item.amount.currencyFormat)"
        if item.type == .phone {
            billNumber.text = "Teléfono: \(item.billNumber)"
        } else {
            billNumber.text = "Recibo: \(item.billNumber)"
        }
        expirationDate.text = "\(item.expirationDate)"
        status.image = item.statusIcon
    }
}
