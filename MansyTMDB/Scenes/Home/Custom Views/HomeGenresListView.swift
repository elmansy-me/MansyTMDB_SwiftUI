//
//  HomeGenresListView.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 05/08/2023.
//

import SwiftUI
import MansyTMDBCore

struct HomeGenresListView: View {
    
    let list: [GenreModel]
    
    var body: some View {
        Section{
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(list, id: \.id) { data in
                        NavigationLink(destination: movieListView(genre: data)) {
                            Text(data.name)
                                .padding()
                                .background(Color(UIColor.systemGroupedBackground))
                                .cornerRadius(8)
                                .font(.subheadline)
                                .foregroundColor(Color(.label))
                        }
                    }
                }
                .padding(16)
            }
            .listRowInsets(EdgeInsets())
        } header: {
            Text("Genres")
                .font(.subheadline)
                .fontWeight(.bold)
        }
    }
    
    @ViewBuilder
    private func movieListView(genre: GenreModel) -> some View {
        GenreMovieListView(viewModel: .init(genre: genre, moviesRepo: .init()))
    }
}

struct HomeGenresListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeGenresListView(list: [])
    }
}
