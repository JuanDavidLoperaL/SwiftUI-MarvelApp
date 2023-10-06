//
//  Characters.swift
//  MarvelApp
//
//  Created by Juan david Lopera lopez on 4/10/23.
//

import UIKit

struct Characters: Identifiable, Decodable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: CharacterThumbnail
    var comics: CharactersComics
    var series: CharactersSeries
    var isGhost: Bool?
}
