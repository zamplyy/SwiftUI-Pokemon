//
//  ExploreGridCell.swift
//  PokemonAppGrid
//
//  Created by Joar Karlsson on 2020-10-05.
//

import Foundation
import SwiftUI
import KingfisherSwiftUI

struct GridCell: View {
    let id: Int
    let pokemon: PokemonData?
    
    var body: some View {
        if let pokemon = pokemon {
            VStack(alignment: .leading, spacing: 4) {
                ZStack {
                    Spacer().frame(width: 100, height: 100).background(pokemon.backgroundColor).opacity(0.8).cornerRadius(22)
                    KFImage(URL(string: pokemon.sprites.other.officialArtwork.front_default))
                        .placeholder({
                            return LoadingIndicator()
                        })
                        .resizable()
                        .scaledToFit()
                }
                Text("\(pokemon.name.capitalized)").font(.footnote)
                Text("\(pokemon.weight)").font(.caption)
                Text("\(pokemon.id)").font(.caption)
                Spacer()
            }.padding(.horizontal)
        } else {
            VStack(alignment: .leading, spacing: 4) {
                ZStack {
                    Spacer().frame(width: 100, height: 100).background(Color.gray).opacity(0.4).cornerRadius(22)
                }
                Text("placeholder").font(.footnote).redacted(reason: .placeholder)
                Text("placeholder2").font(.caption).redacted(reason: .placeholder)
                Text("23").font(.caption).redacted(reason: .placeholder)
                Spacer()
            }.padding(.horizontal)
        }
    }
}
