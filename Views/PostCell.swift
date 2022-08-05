//
//  PostCell.swift
//  T1000_ONLINE_FINAL_PROJECT_1000
//
//  Created by ا on 22/10/1443 AH.
//

import UIKit

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var userStackView: UIStackView!{
        didSet{
            userStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userStackViewTapped)))
        }
    }
    @IBOutlet weak var likesNumberLabel: UILabel!
    @IBOutlet weak var backView: UIView!{
        didSet{
            backView.layer.shadowColor = UIColor.gray.cgColor
            backView.layer.shadowOpacity = 0.3
            backView.layer.shadowOffset = CGSize(width: 0, height: 10)
            backView.layer.shadowRadius = 10
            backView.layer.cornerRadius = 7
        }
    }
    
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: ACTIONS
    @objc func userStackViewTapped(){
        NotificationCenter.default.post(name: NSNotification.Name("userStackViewTapped"), object: nil, userInfo:["cell": self])
    }
}
