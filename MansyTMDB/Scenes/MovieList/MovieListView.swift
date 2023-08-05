//
//  MovieListView.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 03/08/2023.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject var viewModel: MovieListViewModel
    
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
        .navigationTitle(viewModel.section.title)
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

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(viewModel: MovieListViewModel(section: .popular, moviesRepo: .init()))
    }
}
