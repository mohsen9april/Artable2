//
//  Product.swift
//  Artable
//
//  Created by Mohsen Abdollahi on 6/8/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Product {
    
    var name : String
    var id : String
    var category : String
    var price : Double
    var productDescrition : String
    var imageUrl : String
    var timeStamp : Timestamp
    var stock : Int
   
    init (data : [String : Any] ) {
        
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.category = data["category"] as? String ?? ""
        self.price = data["price"] as? Double ?? 0
        self.productDescrition = data["productDescription"] as? String ?? ""
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
        self.stock = data["stock"] as? Int ?? 0
        
    }
}
