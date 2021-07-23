//
//  ReviewResponse.swift
//  Dzulkiflix
//
//  Created by Apple on 23/07/21.
//

import Foundation

class ReviewResponse : Decodable {
    var id: Int?
    var page: Int?
    var results: [Review]?
    var totalPages: Int?
    var totalResults: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id, page, results, totalPages = "total_pages", totalResults = "total_results"
    }
}
