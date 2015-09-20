//
//  LoginView.swift
//  Tertius
//
//  Created by mac on 9/19/15.
//  Copyright (c) 2015 Ryan Li. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!

    @IBAction func signUpTouched(sender: UIButton) {
        signUp(usernameTextField.text!, password: passwordTextField.text!)
    }

    @IBAction func loginTouched(sender: UIButton) {
        logIn(usernameTextField.text!, password: passwordTextField.text!)
    }

    func signUp(username: String, password: String){
        let user = PFUser()
        user.username = username
        user.password = password
        user.signUpInBackgroundWithBlock { [unowned self] succeeded, error in
            if succeeded {
                NSLog("Sign up successfully with \(user.username)");
                self.logIn(username, password: password)
            } else {
                NSLog("An error occured with: \(error)")
            }
        }
    }

    func logIn(username: String, password: String) {
        PFUser.logInWithUsernameInBackground(username, password: password) {
            user, error in
            if let error = error {
                NSLog("Error %@", error.localizedDescription);
            } else {
                if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                    delegate.switchRootViewController()
                }
            }
        }
    }
}