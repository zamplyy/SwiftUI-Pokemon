//
//  SearchPage.swift
//  PokemonAppGrid
//
//  Created by Joar Karlsson on 2020-10-05.
//

import Foundation
import SwiftUI


class SearchPageViewModel: ObservableObject {
    
    var jsonData = Dictionary<String,Int>()
    @Published var searchData = [String]()
    
    func getId(fromName name:String) -> Int? {
        return jsonData[name]
    }
    
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
                    searchData = keys.sorted()
                    jsonData = jsonResult
                  }
              } catch {
                print("Couldn't parse json")
              }
        }
    }
}

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}


struct SearchPage: View {
    @ObservedObject var vm = SearchPageViewModel()
    @State var searchText = ""
    
    var body: some View {
        SearchBar(text: $searchText)
        List {
            ForEach(vm.searchData.filter({ (pokemon) -> Bool in
                self.searchText.isEmpty ? true : pokemon.localizedCaseInsensitiveContains(searchText)
            }), id: \.self, content: { pokemon in
                NavigationLink(
                    destination: NavigationLazyView(DetailsPage(pokemonId: vm.getId(fromName: pokemon) ?? 1)),
                    label: {
                        Text(pokemon)
                    })
            })
        }
            .navigationTitle("Search Pokémons")
    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPage()
    }
}


