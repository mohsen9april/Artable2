//
//  RegisterVC.swift
//  Artable
//
//  Created by Mohsen Abdollahi on 6/5/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassTxt: UITextField!
    @IBOutlet weak var passCheckImage: UIImageView!
    @IBOutlet weak var confirmPassCheckImg: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        activityIndicator.isHidden = true
        super.viewDidLoad()
        
        passwordTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        confirmPassTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        
        if textField == confirmPassTxt {
            passCheckImage.isHidden = false
            confirmPassCheckImg.isHidden = false
        }
        
        if passwordTxt.text == confirmPassTxt.text {
            passCheckImage.image = UIImage(named: "green_check")
            confirmPassCheckImg.image = UIImage(named: "green_check")
        } else {
            passCheckImage.image = UIImage(named: "red_check")
            confirmPassCheckImg.image = UIImage(named: "red_check")
        }
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        
          guard let email = emailTxt.text , !email.isEmpty,
                let username = usernameTxt.text, !username.isEmpty ,
                let password = passwordTxt.text , !password.isEmpty else { return }
        
        activityIndicator.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            if let Error = error {
                debugPrint(Error)
                return
            }
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            print("Successfully Registered new User !")
        }
    }
}
