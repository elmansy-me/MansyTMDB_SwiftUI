//
//  MovieListViewModel.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 03/08/2023.
//

import Foundation
import Combine
import MansyTMDBCore

class MovieListViewModel: BaseViewModel{
    
    let section: MovieSection
    
    @Published var list: [BaseMovieModel] = []
    @Published var isLoading: Bool = false
    @Published var isRequestFailed = false
    
    var isAbleToLoadMore: Bool{
        page != nil
    }

    private var moviesRepo: MoviesRepository
    private var page: Int?

    init(section: MovieSection, moviesRepo: MoviesRepository){
        self.section = section
        self.moviesRepo = moviesRepo
        list = []
        isLoading = false
        isRequestFailed = false
        page = 1
    }
        
    func getData(forceReload: Bool = false){
        guard !isLoading else{return}
        
        if forceReload{
            page = 1
            list.removeAll()
        }
        guard let page else{return}
        isLoading = true
        isRequestFailed = false
        switch section {
        case .popular:
            getPopularMovies(page: page)
        case .topRated:
            getTopRatedMovies(page: page)
        case .upcoming:
            getUpcomingMovies(page: page)
        }
    }
    
    private func handleResponse(usingData data: [BaseMovieModel]?, error: String?, page: Int){
        isLoading = false
        if let data{
            self.list.append(contentsOf: data)
            if data.isEmpty{
                self.page = nil
            }else{
                self.page = page + 1
            }
        }else{
            isRequestFailed = true
            self.error = error
        }
    }
    
    private func getPopularMovies(page: Int){
        moviesRepo.popular(page: page) { [weak self] data, error in
            self?.handleResponse(usingData: data, error: error, page: page)
        }
    }
    
    private func getTopRatedMovies(page: Int){
        moviesRepo.topRated(page: page) { [weak self] data, error in
            self?.handleResponse(usingData: data, error: error, page: page)
        }
    }
    
    private func getUpcomingMovies(page: Int){
        moviesRepo.upcoming(page: page) { [weak self] data, error in
            self?.handleResponse(usingData: data, error: error, page: page)
        }
    }
    
}
