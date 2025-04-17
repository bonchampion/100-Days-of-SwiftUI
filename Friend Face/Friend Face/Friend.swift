//
//  Friend.swift
//  Friend Face
//
//  Created by Bon Champion on 1/28/25.
//

import SwiftData
import Foundation

@Model
class Friend: Codable {
    enum CodingKeys: CodingKey {
        case id, name
    }
    
    private(set) var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}
