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
    
    
    //Variables
    var categories = [Category]()
    var selectedCategory : Category!
    var db : Firestore!
    var listener : ListenerRegistration!
    
    //Outlets
    @IBOutlet weak var loginOutBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        activityIndicator.isHidden = true
        
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
    
    
    
    func fetchDocument(){
        let docRef = db.collection("categories").document("pWTLeAAMyeIrA04pXnXw")
        docRef.addSnapshotListener { (snap, error) in
            self.categories.removeAll()
            guard let data = snap?.data() else { return }
            let newCategory = Category.init(data: data)
            self.categories.append(newCategory)
            self.collectionView.reloadData()
        
        
//        docRef.getDocument { (snap, error ) in
//            guard let data = snap?.data() else { return }
//            let newCategory = Category.init(data: data)
//            self.categories.append(newCategory)
//            self.collectionView.reloadData()
        
        }
    }
    
    func fetchCollection() {
         let collectionReference = db.collection("categories")
       listener =  collectionReference.addSnapshotListener { (snap, error) in
            guard let documents = snap?.documents else { return }
            self.categories.removeAll()
            for document in documents {
                let data = document.data()
                let newCategory = Category.init(data: data)
                self.categories.append(newCategory)
            }
            self.collectionView.reloadData()
        }
    
//        collectionReference.getDocuments { (snap, error ) in
//            guard let documets = snap?.documents else { return }
//            for document in documets {
//                let data = document.data()
//                let newCategory = Category.init(data: data)
//                self.categories.append(newCategory)
//            }
//            self.collectionView.reloadData()
//        }
    }
    

    override func viewDidAppear(_ animated: Bool) {
        
        
//              fetchDocument()
                fetchCollection()

            if let user = Auth.auth().currentUser , !user.isAnonymous {
                //We are logged in
                loginOutBtn.title = "Logout"
            } else {
                loginOutBtn.title = "Login"
            }

       }
    
    override func viewWillDisappear(_ animated: Bool) {
        listener.remove()
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



extension HomeVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell {
            cell.configureCell(category: categories[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        let cellWidth = (width - 30) / 2
        let cellHeight = cellWidth * 1.5
        
        return CGSize(width: cellWidth, height: cellHeight)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item]
        performSegue(withIdentifier: "toProductsVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue .identifier == "toProductsVC" {
            if let destination = segue.destination as? ProductsVC {
                destination.category = selectedCategory
            }
        }
    }
}
