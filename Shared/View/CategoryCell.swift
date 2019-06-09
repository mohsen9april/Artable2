//
//  CategoryCell.swift
//  Artable
//
//  Created by Mohsen Abdollahi on 6/8/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {
    
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        categoryImage.layer.cornerRadius = 5
        
        
    }
    
    func configureCell(category : Category) {
        
        categoryLabel.text = category.name
        if let url = URL(string: category.imgUrl) {
            let placeholder = UIImage(named: "placeholder")
            let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.2))]
            categoryImage.kf.indicatorType = .activity
            categoryImage.kf.setImage(with: url, placeholder: placeholder, options : options )
        }
    }
}
