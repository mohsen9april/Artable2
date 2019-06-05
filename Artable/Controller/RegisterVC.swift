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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        
          guard let email = emailTxt.text , !email.isEmpty,
                let username = usernameTxt.text, !username.isEmpty ,
                let password = passwordTxt.text , !password.isEmpty else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            if let Error = error {
                debugPrint(Error)
                return
            }
            print("Successfully Registered new User !")
        }
    }
}
