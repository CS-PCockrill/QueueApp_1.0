//
//  User.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/28/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

struct User {
    
    let uid: String
    let username: String
    let profileImage: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        
        self.username = dictionary["username"] as? String ?? ""
        self.profileImage = dictionary["profileImageUrl"] as? String ?? ""
    }
}
