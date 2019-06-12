//
//  Category.swift
//  Artable
//
//  Created by Mohsen Abdollahi on 6/8/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Category {
    
    var name: String
    var id : String
    var imageUrl : String
    var isActive : Bool
    var timeStamp : Timestamp
    
    
    
    init(name1: String , id1: String , imageUrl1 : String , isActive1 : Bool = true , timeStamp1: Timestamp) {
        self.name = name1
        self.id = id1
        self.imageUrl = imageUrl1
        self.isActive = isActive1
        self.timeStamp = timeStamp1
    
 
    }
    
    
    
    init (data : [String : Any] ) {
        
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? true
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
        
    }
    
    
    static func modelToData(category : Category) -> [String : Any ]{
        let data : [String : Any] = [
            "name" : category.name,
            "id" : category.id,
            "imageUrl" : category.imageUrl,
            "isActive" : category.isActive,
            "timeStamp" : category.timeStamp
        ]
         return data
    }
    
    
      
}
