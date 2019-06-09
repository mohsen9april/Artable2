//
//  LoginVC.swift
//  Artable
//
//  Created by Mohsen Abdollahi on 6/5/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
    }
    
    
    @IBAction func forgotPassClicked(_ sender: Any) {
        
        let vc = ForgotPasswordVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc , animated:  true , completion:  nil)
        
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        guard let email = emailTxt.text , !email.isEmpty,
            let password = passwordTxt.text , !password.isEmpty else { return }
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        
            Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error  = error {
                self.activityIndicator.stopAnimating()
                self.handleFireAuthError(error: error)
                debugPrint(error)
                return
            }
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            print("Login Was Successful !")
            self.dismiss(animated: true, completion: nil )
        }

    }
    
    @IBAction func guestClicked(_ sender: Any) {
    }
}
