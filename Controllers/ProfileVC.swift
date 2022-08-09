//
//  ProfileVC.swift
//  T1000_ONLINE_FINAL_PROJECT_1000
//
//  Created by ا on 07/01/1444 AH.
//

import UIKit

class ProfileVC: UIViewController {
    

    @IBOutlet weak var profileImageView: UIImageView!{
        didSet{
            profileImageView.makeCircularImage()
            }
    }
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        
        UserAPI.getUserData(id: user.id) { userResponse in
            self.user = userResponse
            self.setupUI()
        }
        

       
    }
    func setupUI(){
        nameLabel.text = user.firstName + "" + user.lastName
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        genderLabel.text = user.gender
        
        if let location = user.location {
            countryLabel.text = location.country! + " - " + location.city!
        }
        
        
        
        profileImageView.setImageFromStringUrl(stringUrl: user.picture!)
        
        
    }

}
