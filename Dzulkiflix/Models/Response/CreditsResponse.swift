//
//  CreditsResponse.swift
//  Dzulkiflix
//
//  Created by Apple on 23/07/21.
//

import Foundation

class CreditsResponse : Decodable {
    var id: Int?
    var cast: [Cast]?
}
