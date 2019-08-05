//
//  ItemCategory.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/5/19.
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
}
