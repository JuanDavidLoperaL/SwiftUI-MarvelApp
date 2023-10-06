//
//  CharacterThumbnail.swift
//  MarvelApp
//
//  Created by Juan david Lopera lopez on 5/10/23.
//

import Foundation

struct CharacterThumbnail: Decodable {
    var imagePath: String
    var imageExtension: String
    
    enum CodingKeys: String, CodingKey {
        case imagePath = "path"
        case imageExtension = "extension"
    }
}
