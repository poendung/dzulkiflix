//
//  DiscoverResponse.swift
//  Dzulkiflix
//
//  Created by Apple on 22/07/21.
//

import Foundation

class DiscoverResponse : Decodable {
    var page: Int
    var results: [Movie]
    var totalPages: Int
    var totalResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case page, results, totalPages = "total_pages", totalResults = "total_results"
    }
}
