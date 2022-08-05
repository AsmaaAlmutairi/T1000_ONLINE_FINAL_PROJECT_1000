//
//  ViewController.swift
//  T1000_ONLINE_FINAL_PROJECT_1000
//
//  Created by ا on 22/10/1443 AH.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class PostsVC: UIViewController {
    @IBOutlet weak var postsTableView: UITableView!
    
    @IBOutlet weak var louderView: NVActivityIndicatorView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.delegate = self
        postsTableView.dataSource = self
        
        //subscribing to the notification
        NotificationCenter.default.addObserver(self, selector: #selector(userProfileTapped), name: NSNotification.Name("userStackViewTapped"), object: nil)
        
        
        let appId = "61bd2d5358b532c456f0e0bd"
        let url = "https://dummyapi.io/data/v1/post"
        
        let headers: HTTPHeaders = [
            "app-id" : appId
        ]
        
        louderView.startAnimating()
        
        
        AF.request(url, headers: headers).responseJSON {  response in
            self.louderView.stopAnimating()
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do {
                self.posts = try decoder.decode([Post].self, from: data.rawData())
                self.postsTableView.reloadData()
            }catch let error{
                print(error)
            }
            
            
           
            print(data)
        }
        
        
        
    }

//MARK: ACTIONS
    @objc func userProfileTapped(notification : Notification){
        if let cell = notification.userInfo?["cell"] as? UITableViewCell {
            if let indexPath = postsTableView.indexPath(for: cell) {
                let post = posts[indexPath.row]
                
                let VC = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
                VC.user = post.owner
                present(VC, animated: true, completion: nil)
                
            }
            
        }
            
        let VC = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        present(VC, animated: true, completion: nil)
       
    }
    
    
}
extension PostsVC: UITableViewDelegate, UITableViewDataSource {
    
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PostCall")as! PostCell
    let post = posts[indexPath.row]
    cell.postTextLabel.text = post.text
    
    // the logic of filling the post's image from the url
    let imageStringUrl = post.image
   
    cell.postImageView.setImageFromStringUrl(stringUrl: imageStringUrl)
    
    // the logic of filling the user's image from the url
    let userImageStringUrl = post.owner.picture
    cell.userImageView.makeCircularImage()
    
    cell.userImageView.setImageFromStringUrl(stringUrl: userImageStringUrl)
    
    
        
  // filling the user data
    cell.userNameLabel.text = post.owner.firstName + "" + post.owner.lastName
    cell.likesNumberLabel.text = String(post.likes)
    return cell
    
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 453
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let seletedPost = posts[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(withIdentifier:"PostDetalesVC") as! PostDetailsVC
       vc.post = seletedPost
        present(vc, animated: true, completion: nil)
    }
}

