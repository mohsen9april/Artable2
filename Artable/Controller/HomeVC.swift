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
        
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                print(result!)
                print("sigin anonymously ")
                if let error = error {
                    debugPrint(error)
                }
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {

            if let user = Auth.auth().currentUser , !user.isAnonymous {
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
        
        guard let user = Auth.auth().currentUser else { return }
        if user.isAnonymous {
            presentLoginController()
        } else {
            do {
               try  Auth.auth().signOut()
                Auth.auth().signInAnonymously { (result, error   ) in
                    if let error = error {
                        debugPrint(error)
                    }
                    
                     self.presentLoginController()
                }
            } catch {
                debugPrint(error)
            }
            
        }
    }
}

