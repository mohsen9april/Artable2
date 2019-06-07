//
//  ViewController.swift
//  Artable
//
//  Created by Mohsen Abdollahi on 6/3/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
    @IBOutlet weak var loginOutBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        
            if let _ = Auth.auth().currentUser {
                //We are logged in
                loginOutBtn.title = "Logout"
            } else {
                loginOutBtn.title = "Login"
            }
        
        }
    
    fileprivate func presentLoginController() {
        let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        present(controller,animated: true , completion: nil)
    }
        
    
    @IBAction func loginOutClicked(_ sender: Any) {
        
        if let _ = Auth.auth().currentUser {
            //We are logged in
            do {
                try Auth.auth().signOut()
                presentLoginController()
            } catch {
                debugPrint(error.localizedDescription)
            }
        } else {
            presentLoginController()
        }
    }
    
   
}

