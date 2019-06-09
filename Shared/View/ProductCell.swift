//
//  ProductCell.swift
//  Artable
//
//  Created by Mohsen Abdollahi on 6/8/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCell: UITableViewCell {
    
    //Outlets
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    func configureCell(product : Product){
        
        productTitle.text = product.name
        //productPrice.text = product.price
        if let url = URL(string: product.imageUrl) {
            productImage.kf.setImage(with: url)
        }
        
    }
    
    
    
    @IBAction func addToCartClicked(_ sender: Any) {
    }
    
    
    @IBAction func favoriteClicked(_ sender: Any) {
    }
    

}
