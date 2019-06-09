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
    var listener : ListenerRegistration!
    var db : Firestore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        setupQuery()

    }
    
    
    func setupQuery() {
        
        listener = db.collection("products").whereField("category", isEqualTo: category.id).order(by:"timeStamp", descending: true).addSnapshotListener({ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            
            snap?.documentChanges.forEach({ (change) in
                let data = change.document.data()
                let product = Product.init(data: data)
                
                switch change.type {
                
                case .added:
                    self.onDocumentAdded(change: change, product: product)
                case .modified:
                    self.onDocumentModified(change: change, product: product)
                case .removed:
                    self.onDocumentRemoved(change: change)
                }
            })
        })
        
        
//          collection("products")
//        Example in CollecyionView ----------
//        func setCategoriesListener(){
//            listener = db.collection("categories").order(by: "timeStamp" , descending : true ).addSnapshotListener({ (snap, error) in
//                if let error = error {
//                    debugPrint(error.localizedDescription)
//                }
//
//                snap?.documentChanges.forEach({ (change) in
//                    let data = change.document.data()
//                    let category = Category.init(data: data)
//
//                    switch change.type {
//                    case.added :
//                        self.onDocumentAdded(change: change , category: category)
//                    case.modified:
//                        self.onDocumentModified(change: change , category: category)
//                    case.removed:
//                        self.onDocumentRemoved(change: change)
//                    }
//                })
//
//
//            })
//        }
        
    }
    

}

extension ProductsVC : UITableViewDelegate , UITableViewDataSource {
    
    func onDocumentAdded(change : DocumentChange , product : Product) {
        let newIndex = Int(change.newIndex)
         products.insert(product, at: newIndex)
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .fade)
    }
    
    func onDocumentModified(change : DocumentChange , product : Product) {
        if change.newIndex == change.oldIndex {
             //Item Change but remainded in the same position
            let index = Int(change.newIndex)
            products[index] = product
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        } else {
            //Item Changed and position
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            products.remove(at: oldIndex)
            products.insert(product, at: newIndex)
            tableView.moveRow(at: IndexPath(row: oldIndex, section: 0), to: IndexPath(row: newIndex, section: 0))
        }
    }
    
    func onDocumentRemoved(change : DocumentChange){
        let oldIndex = Int(change.oldIndex)
        products.remove(at: oldIndex)
        tableView.deleteRows(at: [IndexPath(row: oldIndex, section: 0)], with: .left )
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    
//    func onDocumentAdded(change : DocumentChange , category : Category){
//        let newIndex = Int(change.newIndex)
//        categories.insert(category, at: newIndex)
//        collectionView.insertItems(at: [IndexPath(item: newIndex, section: 0)])
//    }
//
//    func onDocumentModified(change : DocumentChange , category : Category){
//        //Item Change but remainded in the same position
//        if change.newIndex == change.oldIndex {
//            let index = Int(change.newIndex)
//            categories[index] = category
//            collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
//        } else {
//            //Item Changed and position
//            let oldIndex = Int(change.oldIndex)
//            let newIndex = Int(change.newIndex)
//            categories.remove(at: oldIndex)
//            categories.insert(category, at: newIndex)
//            collectionView.moveItem(at: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newIndex, section: 0))
//
//        }
//    }
//
//    func onDocumentRemoved(change : DocumentChange){
//        let oldIndex = Int(change.oldIndex)
//        categories.remove(at: oldIndex)
//        collectionView.deleteItems(at: [IndexPath(item: oldIndex, section: 0)])
//
//
//    }
    
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
