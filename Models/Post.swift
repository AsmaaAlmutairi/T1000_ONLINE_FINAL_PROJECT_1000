//
//  Post.swift
//  T1000_ONLINE_FINAL_PROJECT_1000
//
//  Created by ا on 22/10/1443 AH.
//

import Foundation
import UIKit

struct Post : Decodable {
    var id: String
    var image: String
    var likes: Int
    var text: String
    var owner: User
}
