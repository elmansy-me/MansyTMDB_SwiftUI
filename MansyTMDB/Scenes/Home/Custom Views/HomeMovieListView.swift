//
//  HomeHorizontalMoviesList.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 02/08/2023.
//

import SwiftUI
import MansyTMDBCore

struct HomeMovieListView: View {
    
    let section: MovieSection
    let list: [BaseMovieModel]
    
    var body: some View {
        Section{
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(list, id: \.id) { data in
                        NavigationLink(destination: movieDetailsView(movieId: data.id)) {
                            HomeMovieView(data: data)
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(16)
            }
            .listRowInsets(EdgeInsets())
            .shadow(radius: 4)
        } header: {
            HStack {
                Text(section.title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Spacer()
                NavigationLink(destination: movieListView()) {
                    Text("See All")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
        }
    }
    
    @ViewBuilder
    private func movieDetailsView(movieId: Int) -> some View {
        MovieDetailsView(viewModel: .init(movieId: movieId, repo: .init()))
    }
    
    @ViewBuilder
    private func movieListView() -> some View {
        MovieListView(viewModel: MovieListViewModel(section: section, moviesRepo: MoviesRepository()))
    }
}

struct HomeMovieListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMovieListView(section: .popular, list: BaseMovieModel.mockedList)
    }
}
