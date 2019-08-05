//
//  Item.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import Foundation

struct Item: Decodable {
    var id: Int?
    var itemTitle: String?
    var price: Float?
    var categoryTitle: String?
    //    var condition: String?
    //    var brand: String?
    //    var itemDescription: String?
    var imageName: String?
    
    private enum CodingKeys : String, CodingKey {
        case id = "Id"
        case itemTitle = "Name"
        case price = "Price"
        case categoryTitle = "Category"
        case imageName = "ImageName"
    }
}

