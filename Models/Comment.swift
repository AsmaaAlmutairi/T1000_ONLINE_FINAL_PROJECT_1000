//
//  Comment.swift
//  T1000_ONLINE_FINAL_PROJECT_1000
//
//  Created by ا on 28/10/1443 AH.
//

import Foundation
struct Comment: Decodable{
    var id: String
    var message: String
    var owner: User
}
