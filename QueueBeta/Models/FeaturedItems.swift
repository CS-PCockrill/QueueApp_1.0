//
//  FeaturedItems.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import Foundation

struct FeaturedItems: Decodable {
    
    var itemCategories: [ItemCategory]?
    
    private enum CodingKeys : String, CodingKey {
        case itemCategories = "categories"
    }
    
}

