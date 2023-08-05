//
//  GenreMovieListView.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 05/08/2023.
//

import SwiftUI

struct GenreMovieListView: View {
    
    @ObservedObject var viewModel: GenreMovieListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.list, id: \.id) { data in
                NavigationLink(destination: movieDetailsView(movieId: data.id)) {
                    MovieListMovieView(data: data)
                        .foregroundColor(.black)
                }
            }
            if viewModel.isAbleToLoadMore{
                MovieListLoaderView(isFailed: viewModel.isRequestFailed)
                    .onAppear{
                        viewModel.getData()
                    }
                    .onTapGesture{
                        viewModel.getData()
                    }
            }
        }
        .refreshable {
            viewModel.getData(forceReload: true)
        }
        .listStyle(.grouped)
        .navigationTitle(viewModel.genre.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getData()
        }
    }
    
    @ViewBuilder
    private func movieDetailsView(movieId: Int) -> some View {
        MovieDetailsView(viewModel: .init(movieId: movieId, repo: .init()))
    }
}
