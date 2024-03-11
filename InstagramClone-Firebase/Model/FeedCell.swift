//
//  FeedCell.swift
//  InstagramClone-Firebase
//
//  Created by Ejder Dağ on 10.03.2024.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var cellEmailLbl: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var cellCommentLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }

    @IBAction func likeButtonClicked(_ sender: UIButton) {
    }
}
