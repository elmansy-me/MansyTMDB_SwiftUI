//
//  MoviesSearchView.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 04/08/2023.
//

import SwiftUI

struct MoviesSearchView: View {
    
    @ObservedObject var viewModel: MoviesSearchViewModel
    
    var body: some View {
        List {
            Section{
                TextField("Search", text: $viewModel.searchQuery)
                    .textFieldStyle(.plain)
                    .padding(0)
            } header: {
                Text("Search for a movie")
            }
            
            switch viewModel.state{
            case .waiting:
                EmptyView()
            case .dataAvailable:
                Section{
                    ForEach(viewModel.list, id: \.id) { data in
                        NavigationLink(destination: movieDetailsView(movieId: data.id)) {
                            MovieListMovieView(data: data)
                                .foregroundColor(.black)
                        }
                    }
                } header: {
                    Text("Search results")
                }
            case .loading:
                LoadingView()
                    .frame(maxWidth: .infinity)
            case .noResults:
                ErrorView(message: "No results available")
                    .frame(maxWidth: .infinity)
            case .error(let message):
                ErrorView(message: message)
                    .frame(maxWidth: .infinity)
                
            }
        }
        .listStyle(.grouped)
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
        .padding(0)
    }
    
    @ViewBuilder
    private func movieDetailsView(movieId: Int) -> some View {
        MovieDetailsView(viewModel: .init(movieId: movieId, repo: .init()))
    }
    
}

struct MoviesSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesSearchView(viewModel: .init(repo: .init()))
    }
}
