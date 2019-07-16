//
//  Item.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/15/19.
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









//class Store: NSObject {
//    var storeMerchandise = [Item]()
//    let storeName: String?
//    let storeLocation: String?
//    let storeRating: NSNumber?
//    let storeHours: String?
////    let categoryTitle: String?
//    
//    init(storeName: String?, storeLocation: String?, storeRating: NSNumber?, storeHours: String?, storeMerchandise: [Item]) {
//        self.storeName = storeName
//        self.storeLocation = storeLocation
//        self.storeRating = storeRating
//        self.storeHours = storeHours
//        self.storeMerchandise = storeMerchandise
//    }
//}
