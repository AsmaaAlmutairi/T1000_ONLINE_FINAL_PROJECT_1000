//
//  PostDetailsVC.swift
//  T1000_ONLINE_FINAL_PROJECT_1000
//
//  Created by ا on 27/10/1443 AH.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class PostDetailsVC: UIViewController {
    
    var post: Post!
    var comments: [Comment] = []
    
  // MARK: OUTLETS
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var commentsTabelView: UITableView!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    
    
    //MARK: LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsTabelView.delegate = self
        commentsTabelView.dataSource = self
        
        exitButton.layer.cornerRadius = exitButton.frame.width / 2
        userNameLabel.text = post.owner.firstName + "" + post.owner.lastName
        postTextLabel.text = post.text
        numberOfLikesLabel.text = String(post.likes)
        userImageView.setImageFromStringUrl(stringUrl: post.owner.picture)
        postImageView.setImageFromStringUrl(stringUrl: post.image)
        userImageView.makeCircularImage()

        //getting the comments of the post from the API
        /*let url = "https://dummyapi8
         .io/data/v1/post/60d21af267d0d8992e610b8d/comment"
         */
        let url = "https://dummyapi.io/data/v1/post/\(post.id)/comment"

        let appId = "61bd2d5358b532c456f0e0bd"
        
        
        let headers: HTTPHeaders = [
            "app-id" : appId
        ]
        loaderView.startAnimating()
        AF.request(url, headers: headers).responseJSON { response in
            self.loaderView.stopAnimating()
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            
            let decoder = JSONDecoder()
            do {
                self.comments = try decoder.decode([Comment].self, from: data.rawData())
                self.commentsTabelView.reloadData()
            }catch let error{
                print(error)
            }
           
            
           

        }
        
    }
    
    //MARK: ACTTONS
    @IBAction func closeBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PostDetailsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        let currentComment = comments[indexPath.row]
        cell.userNameLabel.text = currentComment.owner.firstName + "" + currentComment.owner.lastName
        
        cell.commentMessageLabel.text = currentComment.message
        
        cell.userImageView.setImageFromStringUrl(stringUrl: currentComment.owner.picture)
        
        cell.userImageView.makeCircularImage()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107
        
    }
    
}
