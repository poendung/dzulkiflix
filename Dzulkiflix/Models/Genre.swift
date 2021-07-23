//
//  MovieGenre.swift
//  Dzulkiflix
//
//  Created by Apple on 22/07/21.
//

import Foundation

class Genre : Decodable {
    var id: Int!
    var name: String!
    var movies: [Movie]?
}
