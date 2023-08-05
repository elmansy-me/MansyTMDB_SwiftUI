//
//  MovieDetailsViewModel.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 04/08/2023.
//

import Foundation
import Combine
import MansyTMDBCore

class MovieDetailsViewModel: BaseViewModel{
    
    private let movieId: Int
    
    @Published var movie: MovieModel?
    @Published var isLoading: Bool
    
    private var repo: MovieRepository

    init(movieId: Int, repo: MovieRepository){
        self.movieId = movieId
        self.repo = repo
        isLoading = false
    }
        
    func getData(){
        isLoading = true
        getMovieDetails(movieId: movieId)
    }
    
    private func getMovieDetails(movieId id: Int){
        repo.details(id: id) { [weak self] data, error in
            self?.isLoading = false
            if let data{
                self?.movie = data
            }else{
                self?.error = error
            }
        }
    }
    
}
