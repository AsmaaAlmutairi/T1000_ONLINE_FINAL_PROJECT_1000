//
//  PostAPI.swift
//  T1000_ONLINE_FINAL_PROJECT_1000
//
//  Created by ا on 08/01/1444 AH.
//

import Foundation
import Alamofire
import SwiftyJSON

class PostAPI : API {
    
    
    
    static func getAllPosts(comletionHandler: @escaping ([Post]) ->()){
        
        
        let url = baseURL + "/post"
        
        
        AF.request(url, headers: headers).responseJSON {  response in
            
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do {
                let posts = try decoder.decode([Post].self, from: data.rawData())
                comletionHandler(posts)
            }catch let error{
                print(error)
            }
            
            
           
            print(data)
        }
        
    }
    static func getPostComments(id: String, completionHandler: @escaping ([Comment])->()){
        let url = "\(baseURL)/post/\(id)/comment"

        
        
        let headers: HTTPHeaders = [
            "app-id" : appId
        ]
        
        AF.request(url, headers: headers).responseJSON { response in
            
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            
            let decoder = JSONDecoder()
            do {
                let comments = try
                decoder.decode([Comment].self, from: data.rawData())
                completionHandler(comments)
            }catch let error{
                print(error)
            }
           

        }
    }
}
