//
//  Post.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 7/7/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

struct Post {
    let user: User
    let imageUrl: String
    let title: String
    let price: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.imageUrl = dictionary["postImageUrl"] as? String ?? ""
        self.title = dictionary["postTitle"] as? String ?? ""
        self.price = dictionary["price"] as? String ?? ""
//        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
    
}
