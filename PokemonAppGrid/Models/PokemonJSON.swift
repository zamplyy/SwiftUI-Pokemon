//
//  PokemonJSON.swift
//  PokemonAppGrid
//
//  Created by Joar Karlsson on 2020-10-05.
//

import Foundation
import SwiftUI

struct PokemonData: Decodable, Hashable {
    static func == (lhs: PokemonData, rhs: PokemonData) -> Bool {
        return lhs.id == rhs.id
    }
    let id: Int
    let name: String
    let weight: Int
    let sprites: Sprites
    let types: [Type]
}

extension Color {
    init(_ hex: UInt32, opacity:Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

extension PokemonData {
    var backgroundColor: Color {
        switch types.first?.type.name {
            case "normal":  return Color(0xA8A77A)
            case "fighting":  return Color(0xC22E28)
            case "flying":  return Color(0xA98FF3)
            case "poison":  return Color(0xA33EA1)
            case "ground":  return Color(0xE2BF65)
            case "rock":  return Color(0xB6A136)
            case "bug":  return Color(0xA6B91A)
            case "ghost":  return Color(0x735797)
            case "fire":  return Color(0xEE8130)
            case "water":  return Color(0x6390F0)
            case "grass":  return Color(0x7AC74C)
            case "electric":  return Color(0xF7D02C)
            case "psychic":  return Color(0xF95587)
            case "ice":  return Color(0x96D9D6)
            case "dragon":  return Color(0x6F35FC)
            case "dark":  return Color(0x705746)
            case "fairy":  return Color(0xD685AD)
            case "steel":  return Color(0xB7B7CE)
            default :  return Color.black
        }
    }
}

extension Color {
    static let normal = Color(0xA8A77A)
    static let fighting = Color(0xC22E28)
    static let flying = Color(0xA98FF3)
    static let poison = Color(0xA33EA1)
    static let ground = Color(0xE2BF65)
    static let rock = Color(0xB6A136)
    static let bug = Color(0xA6B91A)
    static let ghost = Color(0x735797)
    static let fire = Color(0xEE8130)
    static let water = Color(0x6390F0)
    static let grass = Color(0x7AC74C)
    static let electric = Color(0xF7D02C)
    static let psychic = Color(0xF95587)
    static let ice = Color(0x96D9D6)
    static let dragon = Color(0x6F35FC)
    static let dark = Color(0x705746)
    static let fairy = Color(0xD685AD)
    static let steel = Color(0xB7B7CE)
}


struct Type: Decodable, Hashable  {
    let type: TypeInner
}

struct TypeInner: Decodable, Hashable  {
    let name: String
}

struct Sprites: Decodable, Hashable  {
    let back_default: String
    let other: OtherSprites
}

struct OtherSprites: Decodable, Hashable  {
    let officialArtwork: OfficialArtwork
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Decodable , Hashable {
    let front_default: String
}
