//
//  ViewController.swift
//  TransitionsDemo
//
//  Created by Gabriel Lanata on 13/8/18.
//  Copyright © 2018 Gabriel Lanata. All rights reserved.
//

import UIKit

extension UIView {
    
    var globalFrame: CGRect {
        let window = UIApplication.shared.keyWindow!
        return self.superview!.convert(self.frame, to: window)
    }
    
}

class LoginViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var agenciesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImageView.tintColor  = UIColor.red
        contactButton.tintColor  = UIColor.red
        agenciesButton.tintColor = UIColor.red
        
        logoImageView.transition     = TransitionAnimation(style: .match("logo"), start: 0, duration: 0.6)
        usernameTextField.transition = TransitionAnimation(style: .right, start: 0.0, duration: 0.6)
        passwordTextField.transition = TransitionAnimation(style: .right, start: 0.2, duration: 0.6)
        loginButton.transition       = TransitionAnimation(style: .right, start: 0.4, duration: 0.6)
        contactButton.transition     = TransitionAnimation(style: .bottom, start: 0.2, duration: 0.6)
        agenciesButton.transition    = TransitionAnimation(style: .bottom, start: 0.2, duration: 0.6)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func loginButtonPressed() {
        guard passwordTextField.text == "password" else {
            print("Incorrect password")
            loginButton.shake()
            return
        }
        usernameTextField.transition = TransitionAnimation(style: .left, start: 0.0, duration: 0.6)
        passwordTextField.transition = TransitionAnimation(style: .left, start: 0.2, duration: 0.6)
        //loginButton.transition       = TransitionAnimation(style: .left, start: 0.4, duration: 0.6)
        loginButton.transition = TransitionAnimation(style: .match("action"), start: 0.0, duration: 0.8)
        performSegue(withIdentifier: "MainSegue", sender: nil)
    }

}

