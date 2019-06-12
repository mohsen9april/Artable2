//
//  ViewController.swift
//  ArtableAdmin
//
//  Created by Mohsen Abdollahi on 6/3/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit

class AdminHomeVC: HomeVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem?.isEnabled = false
        
        let addCategoryBtn = UIBarButtonItem(title: "Add Category", style:  .plain , target: self, action: #selector(addCategory))
        navigationItem.rightBarButtonItem = addCategoryBtn
    
    }

    @objc func addCategory() {
         //segue to the add category view
        performSegue(withIdentifier: "ToAddEditCategoryVC", sender: self)
    }

}

