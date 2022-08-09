//
//  User.swift
//  T1000_ONLINE_FINAL_PROJECT_1000
//
//  Created by ا on 22/10/1443 AH.
//

import Foundation
import UIKit

struct User: Decodable {
    var id: String
    var firstName: String
    var lastName: String
    var picture: String?
    var phone: String?
    var email: String?
    var gender: String?
    var location: location?
}
