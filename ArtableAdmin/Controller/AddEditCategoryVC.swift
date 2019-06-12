//
//  AddEditCategoryVC.swift
//  ArtableAdmin
//
//  Created by Mohsen Abdollahi on 6/10/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit
import Firebase

class AddEditCategoryVC: UIViewController {
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var categoryImg: RoundedImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped(_:)))
        tap.numberOfTapsRequired = 1
        categoryImg.isUserInteractionEnabled = true
        categoryImg.addGestureRecognizer(tap)
    }
    
    @objc func imgTapped(_: UITapGestureRecognizer) {
        lunchImagePicker()
        
    }
    
    
    @IBAction func addCategoryClicked(_ sender: Any) {
        activityIndicator.startAnimating() 
        uploadImageThenDocument()
         }
    
    
      func uploadImageThenDocument() {
        
        guard let image = categoryImg.image ,
                let categoryname = nameTxt.text , !categoryname.isEmpty else {
                
            let alert = UIAlertController(title: "Error", message: "Must add Category Name", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert,animated: true , completion: nil)
                
            return
        }
        
        
        // Step 1 : Turn the image into Data
        guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
        
        // Step 2 : Create an Storage Image reference -> a location in firestorage for it to be stored.
        let imageRef = Storage.storage().reference().child("/categoryImages/\(categoryname).jpg")
       
        // Step 3 : Set to the meta data
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        // Step 4 : Upload the data
        imageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                let alert = UIAlertController(title: "Error", message: "Unable to upload image", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert,animated: true , completion: nil)
                self.activityIndicator.stopAnimating()
                return
            }
            
            
            // Step 5 : one the images is uploaded, retrive the download URL.
            imageRef.downloadURL(completion: { (url, error ) in
                
                if let error = error {
                    debugPrint(error.localizedDescription)
                    let alert = UIAlertController(title: "Error", message: "Unable to upload image", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert,animated: true , completion: nil)
                    self.activityIndicator.stopAnimating()
                    return
                }
                
                guard let url = url else { return }
                print(url)
            
            // Step 6 : Upload new category Document to the fireStore categories collection
                self.uploadDocument(url: url.absoluteString)
        })
    }
}


func uploadDocument(url : String ) {
    
    var docRef : DocumentReference!
//    var category = Category.init(name: nameTxt.text!,
//                                 id: "",
//                                 imageUrl: url,
//                                 timeStamp: Timestamp())
    var category = Category.init(name1: nameTxt.text!, id1: "", imageUrl1: url, isActive1: true, timeStamp1: Timestamp())
    print(category.timeStamp)
    print("after Upload : ")
    print(category)
    docRef = Firestore.firestore().collection("categories").document()
    category.id = docRef.documentID
    
    let data = Category.modelToData(category: category)
    print(data)
    docRef.setData(data, merge: true) { (error) in
        
        if let error = error {
            debugPrint(error.localizedDescription)
            let alert = UIAlertController(title: "Error", message: "Unable to upload image", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert,animated: true , completion: nil)
      }
        
        self.navigationController?.popViewController(animated: true)
        
     }
    }
}

extension AddEditCategoryVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    func lunchImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        categoryImg.contentMode = .scaleAspectFill
        categoryImg.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
