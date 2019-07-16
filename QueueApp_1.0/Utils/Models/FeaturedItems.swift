//
//  FeaturedItems.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 7/2/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import Foundation

struct FeaturedItems: Decodable {

    var itemCategories: [ItemCategory]?
    
    private enum CodingKeys : String, CodingKey {
        case itemCategories = "categories"
    }
    
}
