//
//  ExploreGridViewModel.swift
//  PokemonAppGrid
//
//  Created by Joar Karlsson on 2020-10-05.
//

import Foundation
class ExploreGridViewModel: ObservableObject {
    
    @Published var items: [Int: PokemonData] = [:]
    @Published var ids: [Int]
    var offset = 9
    var limit = 10
    
    var baseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    func hasIdInItems(id: Int) -> Bool {
        return true
    }
    
    func loadMoreItems() {
        for number in 0..<limit {
            let id = number + offset
            ids.append(id)
        }
        offset = offset + limit
    }
    
    func requestData(forId id: Int) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else {return}
            do {
                let pokemon = try JSONDecoder().decode(PokemonData.self, from: data)
                DispatchQueue.main.async {
                    self.items[id] = pokemon
                }
            }
            catch {
                print("Failed to decode",error)
            }
        }.resume()
    }
    
    init() {
        ids = Array(1..<9)
    }
}
