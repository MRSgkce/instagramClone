//
//  flow.swift
//  instagramClone
//
//  Created by Mürşide Gökçe on 12.03.2025.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class flow: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var textgonderi: UITextField!
    @IBOutlet weak var imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageview.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(resimsec))
        imageview.addGestureRecognizer(recognizer)
    }
    
    @objc func resimsec() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageview.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func kaydet(_ sender: Any) {
        
      let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        if let data = imageview.image?.jpegData(compressionQuality: 0.5)
            {
            let uuid = UUID().uuidString
            let imagereference = mediaFolder.child("\(uuid).jpg")
            imagereference.putData(data,metadata: nil ) { (metadata,error) in
                
                if error != nil {
                    print(error?.localizedDescription)
                    
                } else {
                    imagereference.downloadURL() { (url,error) in
                        if error == nil {
                            let imageurl = url?.absoluteString
                            let firestoredatabase = Firestore.firestore()
                            var firestorereference : DocumentReference? = nil
                            
                            let firestorepost = ["imageurl" : imageurl!, "postedBy" : Auth.auth().currentUser!.email!,"postcomment" : self.textgonderi
                                .text!,"date" : "date", "likes" : 0] as [String : Any]
                            
                            firestorereference = firestoredatabase.collection("posts").addDocument(data: firestorepost, completion: { (error) in
                                if error != nil {
                                    print(error?.localizedDescription)
                                }else {
                                    self.imageview.image = UIImage(named: "simpsons.png")
                                    self.textgonderi.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            
                        }
                    }
                    
                }
                
            }
        }
    }
}
