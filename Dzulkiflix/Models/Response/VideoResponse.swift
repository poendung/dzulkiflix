//
//  VideoResponse.swift
//  Dzulkiflix
//
//  Created by Apple on 23/07/21.
//

import Foundation

class VideoResponse : Decodable {
    var id: Int?
    var results: [Video]?
}
