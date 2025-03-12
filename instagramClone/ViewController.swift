//
//  ViewController.swift
//  instagramClone
//
//  Created by Mürşide Gökçe on 12.03.2025.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
    }
    
    @IBAction func signUp(_ sender: Any) {
        if email.text != "" && password.text != "" {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authdata,error) in
                if error != nil {
                    self.makealaert(title: "kullanıcı kayıt edilemdei", message: error?.localizedDescription ?? "error")
                    
                }else{
                    self.performSegue(withIdentifier: "toMain", sender: nil)
                    
                }
            }
            
        } else {
            makealaert(title: "alanlar boş bırakıldı", message: "username/password boş")
        }
        
    }
        
        @IBAction func signIn(_ sender: Any) {
            if email.text != "" && password.text != "" {
                Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (authdata,error) in
                    
                    if error != nil{
                        self.makealaert(title: "error", message: error?.localizedDescription ?? "error")
                    } else {
                        self.performSegue(withIdentifier: "toMain", sender: nil)
                    }
                }
                
            } else { makealaert(title: "error", message: "username/password boş bırakma")}
            
        }
        
        
        
        func makealaert (title: String, message: String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "tamam", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }

