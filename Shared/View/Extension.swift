//
//  Extension.swift
//  Artable
//
//  Created by Mohsen Abdollahi on 6/7/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit

extension UIViewController {
    func handleFireAuthError(error: Error){
        
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert,animated: true , completion: nil)
         
    }
}
