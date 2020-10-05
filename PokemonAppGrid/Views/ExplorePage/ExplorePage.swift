//
//  ContentView.swift
//  PokemonAppGrid
//
//  Created by Joar Karlsson on 2020-10-05.
//

import SwiftUI


struct ExplorePage: View {
    @ObservedObject var vm = ExploreGridViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 100, maximum: 200),spacing: 12,alignment: .top),
                GridItem(.flexible(minimum: 100, maximum: 200),spacing: 12,alignment: .top),
                GridItem(.flexible(minimum: 100, maximum: 200),alignment: .top),
            ], spacing: 12, content: {
                ForEach(vm.ids, id: \.self) { id  in
                    GridCell(id: id, pokemon: vm.items[id]).onAppear(
                        perform: {
                            if (vm.items[id] == nil ) {
                                vm.requestData(forId: id)
                            }
                        }
                    )
                }
            })
            .padding(.horizontal,12)
            LoadMoreButton( gridViewModel: vm)
        }
        .navigationTitle("Pokémons")
    }
}

struct ExplorePage_Previews: PreviewProvider {
    static var previews: some View {
        ExplorePage()
    }
}

struct LoadMoreButton: View {
    let gridViewModel: ExploreGridViewModel
    
    var body: some View {
        Button( action: {
            gridViewModel.loadMoreItems()
        }, label: {
            HStack {
                Image(systemName: "arrow.triangle.2.circlepath.circle")
                    .font(.headline)
                Text("Load more")
                    .fontWeight(.semibold)
                    .font(.subheadline)
            }
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
        })
    }
}
