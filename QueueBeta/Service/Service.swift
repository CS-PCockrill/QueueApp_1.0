//
//  Service.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/14/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import Foundation
import UIKit

class Service {
    
    static let shared = Service() // singleton
    
    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/25/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    // Helper function
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
        
    }
    // Generic JSON call fetch function
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let error = err {
                completion(nil, error)
                //                print("failed to fetch data", error)
                return
            }
            
            do {
                // Successful case
                let appGroup = try JSONDecoder().decode(T.self, from: data!)
                completion(appGroup, nil)
            } catch {
                completion(nil, error)
                //                print("Failed to decode", error)
            }
            
        }.resume()
    }
    
}
