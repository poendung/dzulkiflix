//
//  Review.swift
//  Dzulkiflix
//
//  Created by Apple on 23/07/21.
//

import Foundation

class Review : Decodable {
    var author: String?
    var content: String?
    var createdAt: Date?
    var authorDetails: Author?
    
    private enum CodingKeys: String, CodingKey {
        case author, content, createdAt = "created_at", authorDetails = "author_details"
    }
}

class Author : Decodable {
    var name: String?
    var username: String?
    var avatarPath: String?
    var rating: Int?
    
    private enum CodingKeys: String, CodingKey {
        case name, username, avatarPath = "avatar_path", rating
    }
}
