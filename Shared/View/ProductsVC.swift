//
//  ProductsVC.swift
//  Artable
//
//  Created by Mohsen Abdollahi on 6/8/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ProductsVC: UIViewController {
    
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // Variables
    var products = [Product]()
    var category : Category! 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        let product = Product.init(name: "Test1",
                                   id: "Number1",
                                   category: "Nature",
                                   price: 24.99,
                                   productDescrition: "What a lovely Photo !",
                                   imageUrl: "https://www.crondonpark.com/wp-content/uploads/2018/12/love-3581038_960_720.jpg",
                                   timeStamp: Timestamp(),
                                   stock: 0,
                                   favorite: false)
        products.append(product)
        
        
        tableView.delegate = self
        tableView.dataSource = self

    }
 
}

extension ProductsVC : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell {
            cell.configureCell(product: products[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}
