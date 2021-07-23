//
//  Cast.swift
//  Dzulkiflix
//
//  Created by Apple on 23/07/21.
//

import Foundation

class Cast : Decodable {
    var id: Int?
    var department: String?
    var name: String?
    var character: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, department = "known_for_department", name, character
    }
}
