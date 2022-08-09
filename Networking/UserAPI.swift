//
//  UserAPI.swift
//  T1000_ONLINE_FINAL_PROJECT_1000
//
//  Created by ا on 09/01/1444 AH.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserAPI: API {
    static func getUserData(id: String,completionHandler:@escaping (User)->()){
        
        let url = "\(baseURL)/user/\(id)"
        
        AF.request(url, headers: headers).responseJSON {  response in
            let jsonData = JSON(response.value)
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: jsonData.rawData())
                completionHandler(user)
                
            }catch let error{
                print(error)
            }
            
        }
    }
    
    
    static func registerNewUser( firstName: String?, lastName: String?,email: String?, completionHandler:@escaping (User?,String?)->()){
        
        let url = "\(baseURL)/user/create"
        let params = [
            "firstName" : firstName ,
                "lastName":  lastName ,
                "email" : email
        ]
        
        AF.request(url, method: .post,parameters: params,encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON {  response in
            switch response.result{
            case .success:
                let jsonData = JSON(response.value)
                print(jsonData)
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: jsonData.rawData())
                    completionHandler(user, nil)
                    
                }catch let error{
                    print(error)
                }
            case .failure(let error):
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                let emailError = data["email"].stringValue
                
                completionHandler(nil, emailError)
                print(emailError)
            }
            
            
        }
    }
}

