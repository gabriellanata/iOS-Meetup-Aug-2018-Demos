//
//  DashboardViewController.swift
//  TransitionsDemo
//
//  Created by Gabriel Lanata on 13/8/18.
//  Copyright © 2018 Gabriel Lanata. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImageView.tintColor  = UIColor.red
        addButton.tintColor  = UIColor.red
        
        logoImageView.transition = TransitionAnimation(style: .match("logo"), start: 0, duration: 0.6)
        navBarView.transition    = TransitionAnimation(style: .fade, start: 0.0, duration: 0.8)
        //addButton.transition     = TransitionAnimation(style: .bottom, start: 0.2, duration: 0.6)
        addButton.transition = TransitionAnimation(style: .match("action"), start: 0.0, duration: 0.8)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.transition = TransitionAnimation(style: .right, start: 0.2+(Double(indexPath.row)*0.2), duration: 0.5)
        return cell
    }
    
}

