//
//  ViewController.swift
//  InstagramClone-Firebase
//
//  Created by Ejder Dağ on 4.03.2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func signInClickeed(_ sender: UIButton) {
        performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        
        if emailTf.text != "" && passwordTf.text != "" {
            
            Auth.auth().createUser(withEmail: emailTf.text!, password: passwordTf.text!) { (authData, error) in
                
                if error != nil {
                    self.makeAlert(titleInput: "Error!!!", messageInput: error?.localizedDescription ?? "Error???")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            
           makeAlert(titleInput: "Erororor", messageInput: "Email/Password!!!")
        }
       
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OKOKOKOK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

