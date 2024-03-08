//
//  SettingsViewController.swift
//  InstagramClone-Firebase
//
//  Created by Ejder Dağ on 5.03.2024.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logOutClicked(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toLoginVC", sender: nil)
        } catch {
            print("SignOut Error")
        }
        
        
    }
    


}
