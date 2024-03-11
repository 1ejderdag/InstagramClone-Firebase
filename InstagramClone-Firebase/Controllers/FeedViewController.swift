//
//  FeedViewController.swift
//  InstagramClone-Firebase
//
//  Created by Ejder Dağ on 5.03.2024.
//

import UIKit
import FirebaseFirestore

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        
        cell.cellEmailLbl.text = "user@email.com"
        cell.cellImageView.image = UIImage(named: "tapToSelect")
        cell.likesLbl.text = "0"
        cell.cellCommentLbl.text = "Comments here"
        
        return cell
    }
}
