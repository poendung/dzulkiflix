//
//  Movie.swift
//  Dzulkiflix
//
//  Created by Apple on 22/07/21.
//

import Foundation

class Movie : Decodable {
    var id: Int!
    var backdropPath: String?
    var originalTitle: String?
    var overview: String?
    var posterPath: String?
    var releaseDate: Date?
    var title: String?
    var voteAverage: Float?
    var tagline: String?
    var genres: [Genre]?
    var runtime: Int?
    
//    public var description: String { return originalTitle }
    
    private enum CodingKeys: String, CodingKey {
        case id,
             backdropPath = "backdrop_path",
             originalTitle = "original_title",
             overview,
             posterPath = "poster_path",
             releaseDate = "release_date",
             title,
             voteAverage = "vote_average",
             tagline,
             genres,
             runtime
    }
}
