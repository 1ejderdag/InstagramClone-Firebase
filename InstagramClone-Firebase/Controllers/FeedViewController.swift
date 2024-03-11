//
//  FeedViewController.swift
//  InstagramClone-Firebase
//
//  Created by Ejder Dağ on 5.03.2024.
//

import UIKit
import FirebaseFirestore
import SDWebImage

struct Post {
    var imageUrl: String
    var commentPost: String
    var likes: Int
    var postedBy: String
    var documentID: String
}

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        getDataFromFirestore()
        
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        
        cell.cellEmailLbl.text = posts[indexPath.row].postedBy
        cell.likesLbl.text = String(posts[indexPath.row].likes)
        cell.cellCommentLbl.text = posts[indexPath.row].commentPost
        
        cell.cellImageView.sd_setImage(with: URL(string: posts[indexPath.row].imageUrl))
        
        return cell
        
    }
    
    func getDataFromFirestore() {
        
        
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").order(by: "date", descending: true)
            .addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.posts.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        
                        if let postedBy = document.get("postedBy"),
                           let likes = document.get("likes") as! Int?,
                           let commentPost = document.get("commentPost"),
                           let imageUrl = document.get("imageUrl") {
                            
                            let newPost = Post(imageUrl: imageUrl as! String,
                                               commentPost: commentPost as! String,
                                               likes: likes,
                                               postedBy: postedBy as! String,
                                               documentID: document.documentID)
                            self.posts.append(newPost)
                            
                            self.tableView.reloadData()
                        }
                            
                            
                    }
                }
            }
        }
        
    }
}
