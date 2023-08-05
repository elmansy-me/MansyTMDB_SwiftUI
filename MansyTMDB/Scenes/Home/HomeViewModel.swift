//
//  HomeViewModel.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 02/08/2023.
//

import Foundation
import Combine
import MansyTMDBCore

class HomeViewModel: BaseViewModel{
    
    @Published var genres: [GenreModel] = []
    @Published var popularMovies: [BaseMovieModel] = []
    @Published var topRatedMovies: [BaseMovieModel] = []
    @Published var upcomingMovies: [BaseMovieModel] = []
    @Published var isLoading: Bool = false
    
    private var moviesRepo: MoviesRepository
    private var genresRepo: GenresRepository

    init(moviesRepo: MoviesRepository,
         genresRepo: GenresRepository){
        self.moviesRepo = moviesRepo
        self.genresRepo = genresRepo
    }
        
    func getData(){
        isLoading = true
        getGenres()
        getPopularMovies()
        getTopRatedMovies()
        getUpcomingMovies()
    }
    
    private func getGenres(){
        genresRepo.moviesGenres { [weak self] data, error in
            self?.isLoading = false
            if let data{
                self?.genres = data
            }else{
                self?.error = error
            }
        }
    }
    
    private func getPopularMovies(){
        moviesRepo.popular(page: 1) { [weak self] data, error in
            self?.isLoading = false
            if let data{
                self?.popularMovies = data
            }else{
                self?.error = error
            }
        }
    }
    
    private func getTopRatedMovies(){
        moviesRepo.topRated(page: 1) { [weak self] data, error in
            self?.isLoading = false
            if let data{
                self?.topRatedMovies = data
            }else{
                self?.error = error
            }
        }
    }
    
    private func getUpcomingMovies(){
        moviesRepo.upcoming(page: 1) { [weak self] data, error in
            self?.isLoading = false
            if let data{
                self?.upcomingMovies = data
            }else{
                self?.error = error
            }
        }
    }
    
}
