//
//  AppGroup.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/14/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import Foundation
import UIKit

struct AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResults]
}

// Temp
struct CategoryItems: Decodable {
    let id, name: String
    let resultCount: Int
    let results: [Result]
}

struct FeedResults: Decodable {
    let id, name, artistName, artworkUrl100: String
}

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String // app icon
    let formattedPrice: String
    let description: String
    let releaseNotes: String
}
