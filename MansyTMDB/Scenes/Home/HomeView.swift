//
//  HomeView.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 02/08/2023.
//

import SwiftUI
import MansyTMDBCore

struct HomeView: View {
    
    @ObservedObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            contentView()
                .padding(0)
                .navigationTitle("CineMansy")
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: moviesSearchView()) {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                }
        }
        .onAppear {
            viewModel.getData()
        }
    }
}

extension HomeView{
    
    @ViewBuilder
    private func moviesSearchView() -> some View {
        MoviesSearchView(viewModel: .init(repo: .init()))
    }
    
    @ViewBuilder
    private func contentView()->some View{
        if viewModel.isLoading{
            LoadingView()
        }else if let error = viewModel.error{
            ErrorView(message: error)
        }else{
            List {
                if !viewModel.genres.isEmpty{
                    HomeGenresListView(list: viewModel.genres)
                }
                if !viewModel.topRatedMovies.isEmpty{
                    HomeMovieListView(section: .topRated, list: viewModel.topRatedMovies)
                }
                if !viewModel.popularMovies.isEmpty{
                    HomeMovieListView(section: .popular, list: viewModel.popularMovies)
                }
                if !viewModel.upcomingMovies.isEmpty{
                    HomeMovieListView(section: .upcoming, list: viewModel.upcomingMovies)
                }
            }
            .listStyle(.grouped)
        }
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(moviesRepo: MoviesRepository(), genresRepo: GenresRepository()))
    }
}
