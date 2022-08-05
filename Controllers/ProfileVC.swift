//
//  ProfileVC.swift
//  T1000_ONLINE_FINAL_PROJECT_1000
//
//  Created by ا on 07/01/1444 AH.
//

import UIKit
import Alamofire
import SwiftyJSON

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
        

        let appId = "61bd2d5358b532c456f0e0bd"
        let url = "https://dummyapi.io/data/v1/user/\(user.id)"
        
        let headers: HTTPHeaders = [
            "app-id" : appId
        ]
        
        
        AF.request(url, headers: headers).responseJSON {  response in
            let jsonData = JSON(response.value)
            let decoder = JSONDecoder()
            do {
                self.user = try decoder.decode(User.self, from: jsonData.rawData())
                self.setupUI()
                
            }catch let error{
                print(error)
            }
            
            
           
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
        
        
        
        profileImageView.setImageFromStringUrl(stringUrl: user.picture)
        
        
    }

}
