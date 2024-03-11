//
//  UploadViewController.swift
//  InstagramClone-Firebase
//
//  Created by Ejder Dağ on 5.03.2024.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var commentTf: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true // can be clicked
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage() {
        
        let pickerContorller = UIImagePickerController()
        pickerContorller.delegate = self
        pickerContorller.sourceType = .photoLibrary
        present(pickerContorller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction func uploadButtonClicked(_ sender: UIButton) {
        
        let storage = Storage.storage()
        
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                
                if error != nil {
                    self.makeAlert(titleInput: "ERROR!!", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    imageReference.downloadURL { (url, error) in
                        
                        if error != nil {
                            self.makeAlert(titleInput: "ERROR!!", messageInput: error?.localizedDescription ?? "Error")
                        } else {
                            let imageUrl = url?.absoluteString
                        
                            // DATABASE - FİRESTORE
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReference: DocumentReference?
                            
                            let firestorePost: [String: Any] = ["imageUrl": imageUrl!, "postedBy": Auth.auth().currentUser!.email!, "commentPost": self.commentTf.text!, "date": FieldValue.serverTimestamp(), "likes": 0]
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "Errorrr", messageInput: error?.localizedDescription ?? "Errorr")
                                } else {
                                    self.imageView.image = UIImage(named: "tapToSelect")
                                    self.commentTf.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                                
                            })
                        }
                        
                    }
                }
            }
        }
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OKOKOKOK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
