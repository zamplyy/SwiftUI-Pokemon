//
//  DetailsPage.swift
//  PokemonAppGrid
//
//  Created by Joar Karlsson on 2020-10-06.
//

import Foundation
import SwiftUI
import KingfisherSwiftUI

class DetailsPageViewModel: ObservableObject {
    
    @Published var pokemon:PokemonData?
    
    func requestData(forId id: Int) -> PokemonData? {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/") else {
            return nil
        }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else {return}
            do {
                let pokemon = try JSONDecoder().decode(PokemonData.self, from: data)
                DispatchQueue.main.async {
                    return self.pokemon = pokemon
                }
            }
            catch {
                print("Failed to decode",error)
            }
        }.resume()
        return nil
    }
    
    init(id pokemonId: Int) {
        if let pokemonData = self.requestData(forId: pokemonId) {
            self.pokemon = pokemonData
        }
    }
}


struct DetailsPage: View {
    init(pokemonId: Int) {
        vm = DetailsPageViewModel(id: pokemonId)
    }
    
    @ObservedObject var vm : DetailsPageViewModel
    
    var body: some View {
        if let pokemon = vm.pokemon {
            ZStack {
                HStack {
                    LinearGradient(gradient: Gradient(colors: [pokemon.backgroundColor, Color.black]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                }.opacity(0.7)
                VStack {
                    HStack {
                        KFImage(URL(string: pokemon.sprites.back_default))
                            .resizable()
                            .frame(width: 150 , height: 150)
                            .scaledToFill()
                        KFImage(URL(string:pokemon.sprites.other.officialArtwork.front_default))
                            .resizable()
                            .frame(width: 150 , height: 150)
                            .scaledToFill()
                    }
                    ZStack {
                        Color.black
                            .frame(width: 300.0, height: 300.0)
                            .opacity(0.6)
                            .cornerRadius(25.0)
                            .shadow(radius: 10)
                        VStack {
                            Text(pokemon.name.capitalized)
                                .foregroundColor(Color.white)
                                .font(.largeTitle)
                            Text("\(pokemon.weight)")
                                .foregroundColor(Color.white)
                                .font(.callout)
                            Text("Type:")
                                .font(.title)
                                .foregroundColor(Color.white)
                            Text(pokemon.types.first?.type.name ?? "Couldn't get type")
                                .foregroundColor(Color.white)
                                .font(.callout)
                        }
                    }
                    Spacer()
                }
            }
            .navigationTitle(pokemon.name.capitalized)
        } else {
            
        }
        
    }
}

struct DetailsPage_Previews: PreviewProvider {
    static var previews: some View {
        DetailsPage(pokemonId: 1)
    }
}



