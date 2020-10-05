//
//  HomePage.swift
//  PokemonAppGrid
//
//  Created by Joar Karlsson on 2020-10-05.
//

import SwiftUI

struct HomePage: View {
    init() {
        let font = UIFont(name: "PokemonHollowNormal", size: 32)
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : font!, .foregroundColor: UIColor.black]
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: nil, content: {
                HStack(alignment: .center, spacing: nil, content: {
                    NavigationLink(
                        destination: ExplorePage(),
                        label: {
                            Text("Explore Pokémons")
                                .font(.title)
                                .shadow(color: .black, radius: 5, x: 2, y: 2)
                                .padding()
                                .foregroundColor(Color.white)
                            
                            Spacer()
                        }
                    )
                    .background(Color.fighting)
                    .cornerRadius(3.0)
                    .shadow(color: .black, radius: 5, x: 2, y: 2)
                })
                HStack(alignment: .center, spacing: nil, content: {
                    NavigationLink(
                        destination: SearchPage(),
                        label: {
                            Spacer()
                            Text("Search Pokémons")
                                .font(.title)
                                .shadow(color: .black, radius: 5, x: 2, y: 2)
                                .padding()
                                .foregroundColor(Color.white)
                        }
                    )
                    .background(Color.psychic)
                    .cornerRadius(3.0)
                    .shadow(color: .black, radius: 5, x: 2, y: 2)
                })
                Spacer()
            }).padding()
            .navigationTitle("Home Page")
            
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}


