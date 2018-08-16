//
//  AdaptedViewController.swift
//  Accessibility
//
//  Created by Marco Salazar on 8/13/18.
//  Copyright © 2018 Scotiabank Peru. All rights reserved.
//

import UIKit

final class AdaptedViewController: UITableViewController {
    
    private let items = BillModel.items
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "adaptedCell", for: indexPath) as? AdaptedlCell else {
            assertionFailure("Invalid data")
            return UITableViewCell()
        }
        cell.configure(with: items[indexPath.row])
        return cell
    }
    
}


final class AdaptedlCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var expirationDate: UILabel!
    @IBOutlet weak var status: UIImageView!
    
    
    func configure(with item: BillModel) {
        icon.image = item.icon
        name.text = item.name
        amount.text = "Monto \(item.amount.currencyFormat)"
        status.image = item.statusIcon
        if item.status == .paid {
            expirationDate.text = "Pagado el \(item.expirationDate)"
        } else {
            expirationDate.text = "Vence el \(item.expirationDate)"
        }
//        setAccessibility(with: item)
        setAccessibilityIndependent(with: item)
    }
}

extension AdaptedlCell {
    func setAccessibility(with item: BillModel) {
        icon.accessibilityTraits = UIAccessibilityTraitImage
        
        name.accessibilityTraits = UIAccessibilityTraitStaticText
        name.font = UIFont.preferredFont(forTextStyle: .body)
        name.adjustsFontForContentSizeCategory = true
        
        expirationDate.accessibilityTraits = UIAccessibilityTraitStaticText
        expirationDate.font = UIFont.preferredFont(forTextStyle: .body)
        expirationDate.adjustsFontForContentSizeCategory = true
        if item.status == .paid {
            name.accessibilityValue = "\(item.name), Pagado"
            name.accessibilityLabel = "\(item.name), Pagado"
            expirationDate.accessibilityValue = "Pagado el \(item.expirationDate)"
        } else {
            name.accessibilityValue = "\(item.name), Pendiente de pago"
            name.accessibilityLabel = "\(item.name), Pendiente de pago"
            expirationDate.accessibilityValue = "Vence el \(item.expirationDate)"
        }
        
        let amountValue = "Monto \(item.amount.accessiblityFormat)"
        amount.accessibilityTraits = UIAccessibilityTraitStaticText
        amount.accessibilityValue = amountValue
        amount.accessibilityLabel = amountValue
        amount.font = UIFont.preferredFont(forTextStyle: .body)
        amount.adjustsFontForContentSizeCategory = true
    }
    
    
    
    
    
    
    func setAccessibilityIndependent(with item: BillModel) {
        icon.accessibilityTraits = UIAccessibilityTraitImage
        
        name.isAccessibilityElement = true
        name.accessibilityTraits = UIAccessibilityTraitStaticText
        name.font = UIFont.preferredFont(forTextStyle: .body)
        name.adjustsFontForContentSizeCategory = true
        name.accessibilityLabel = item.name
        if item.status == .paid {
            name.accessibilityValue = "pagado"
        } else {
            name.accessibilityValue = "pendiente"
        }
        
        amount.isAccessibilityElement = true
        amount.accessibilityTraits = UIAccessibilityTraitStaticText
        amount.accessibilityLabel = "Monto"
        amount.accessibilityValue =  item.amount.accessiblityFormat
        amount.font = UIFont.preferredFont(forTextStyle: .body)
        amount.adjustsFontForContentSizeCategory = true
        
        expirationDate.isAccessibilityElement = true
        expirationDate.accessibilityTraits = UIAccessibilityTraitStaticText
        expirationDate.font = UIFont.preferredFont(forTextStyle: .body)
        expirationDate.adjustsFontForContentSizeCategory = true
    }
}
