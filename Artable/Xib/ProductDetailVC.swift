//
//  ProductDetailVC.swift
//  Artable
//
//  Created by Mohsen Abdollahi on 6/10/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var bgView: UIVisualEffectView!
    
    var product : Product!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        productTitle.text = product.name
        productDescription.text = product.productDescrition
        
        if let url = URL(string: product.imageUrl) {
            productImg.kf.setImage(with: url)
        }
        
        let formmater = NumberFormatter()
        formmater.numberStyle = .currency
        if let price = formmater.string(from: product.price as NSNumber){
            productPrice.text = price
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissProduct1(_:)) )
        tap.numberOfTapsRequired = 1
        bgView.isUserInteractionEnabled = true
        bgView.addGestureRecognizer(tap)

     }
    
    @objc func dismissProduct1(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addCartClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissProduct(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
