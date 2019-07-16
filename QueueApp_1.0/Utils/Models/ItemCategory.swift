//
//  ItemCategory.swift
//  QueueApp_1.0
//
//  Created by Patrick Cockrill on 6/15/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import Foundation

struct ItemCategory: Decodable {
    
    let name: String
    var items: [Item]?
    var type: String
    
    static func fetchFeaturedItems(_ completionHandler: @escaping (FeaturedItems) -> ()) {
        
        guard let url = URL(string: "https://api.letsbuildthatapp.com/appstore/featured") else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            do {
                
                guard let data = data else { return }
                
                let featuredItems = try JSONDecoder().decode(FeaturedItems.self, from: data)
                
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(featuredItems)
                })
                
            } catch let err {
                print(err)
            }
            
        }) .resume()
        
    }
    
    static func sampleItemCategories() -> [ItemCategory] {
        var items = [Item]()
        let item1 = Item(id: 1, itemTitle: "IPhone X", price: 400, categoryTitle: "Mobile", imageName: "iPhone")
        items.append(item1)
        
        let bestLocalPicks = ItemCategory(name: "Local Picks", items: items, type: "")
        
        var bestMobile = [Item]()
        let item2 = Item(id: 2, itemTitle: "Car", price: 20000, categoryTitle: "Vehicle", imageName: "car2019")
        bestMobile.append(item2)
        
        let bestCategory = ItemCategory(name: "Category", items: bestMobile, type: "")
        
        return [bestLocalPicks, bestCategory]
    }
    
}
