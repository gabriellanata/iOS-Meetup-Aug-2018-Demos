//
//  BillModel.swift
//  Accessibility
//
//  Created by Marco Salazar on 8/13/18.
//  Copyright © 2018 Scotiabank Peru. All rights reserved.
//

import UIKit

struct BillModel {
    
    let name: String
    let amount: Double
    let billNumber: String
    let expirationDate: String
    let type: BillType
    let status: BillStatus
    
    enum BillType {
        case water, phone, power, school
    }
    
    enum BillStatus {
        case paid, pending
    }
    
    var icon: UIImage {
        switch type {
        case .water: return UIImage(named: "water")!
        case .phone: return UIImage(named: "phone")!
        case .power: return UIImage(named: "power")!
        case .school: return UIImage(named: "school")!
        }
    }
    
    var statusIcon: UIImage {
        switch status {
        case .paid: return UIImage(named: "paid")!
        case .pending: return UIImage(named: "pending")!
        }
    }
}

extension BillModel {
    static var items: [BillModel] {
        return [
            BillModel(name: "Claro celular", amount: 35, billNumber: "999 999 999", expirationDate: "13 de ago, 2018", type: .phone, status: .paid),
//            BillModel(name: "Pago de agua", amount: 20, billNumber: "234435345", expirationDate: "15 de ago, 2018", type: .water, status: .paid),
            BillModel(name: "Universidad de la Paz", amount: 1500, billNumber: "9083479343", expirationDate: "23 de sept, 2018", type: .school, status: .pending),
//            BillModel(name: "Colegio Lincon", amount: 800, billNumber: "1234345324", expirationDate: "23 de sept, 2018", type: .school, status: .pending)
        ]
    }
}
