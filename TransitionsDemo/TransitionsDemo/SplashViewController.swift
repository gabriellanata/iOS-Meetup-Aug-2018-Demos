//
//  SplashViewController.swift
//  TransitionsDemo
//
//  Created by Gabriel Lanata on 13/8/18.
//  Copyright © 2018 Gabriel Lanata. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loadingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImageView.tintColor = UIColor.red
        
        backgroundView.transition = TransitionAnimation(style: .fade, start: 0, duration: 0.4)
        logoImageView.transition = TransitionAnimation(style: .match("logo"), start: 0, duration: 0.6)
        loadingView.transition = TransitionAnimation(style: .fade, start: 0.0, duration: 0.4)
        
        loadingView.rotate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            self.openLogin()
        }
    }
    
    func openLogin() {
        performSegue(withIdentifier: "LoginSegue", sender: nil)
    }
    
}

