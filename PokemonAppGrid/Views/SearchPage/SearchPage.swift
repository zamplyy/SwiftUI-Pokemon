//
//  SearchPage.swift
//  PokemonAppGrid
//
//  Created by Joar Karlsson on 2020-10-05.
//

import Foundation
import SwiftUI


class SearchPageViewModel: ObservableObject {
    
    @Published var jsonData = Dictionary<String,Int>()
    @Published var jsonKeys = [String]()
    
    init() {
        if let path = Bundle.main.path(forResource: "PokemonSearchData", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let jsonResult = jsonResult as? Dictionary<String, Int> {
                    let keys: [String] = [String] ((
                        try! JSONSerialization.jsonObject(
                            with: data,
                            options: .mutableContainers
                        ) as! [String: Any]).keys)
                    jsonKeys = keys
                    jsonData = jsonResult
                  }
              } catch {
                print("Couldn't parse json")
              }
        }
    }
}


struct SearchPage: View {
    @ObservedObject var vm = SearchPageViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(vm.jsonKeys, id: \.self, content: { pokemon in
                Text(pokemon)
            })
        }
        
        Text("Jello")
            .navigationTitle("Search Pokémons")
    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPage()
    }
}


