//
//  GenreMovieListViewModel.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 05/08/2023.
//

import Foundation
import Combine
import MansyTMDBCore

class GenreMovieListViewModel: BaseViewModel{
    
    let genre: GenreModel
    
    @Published var list: [BaseMovieModel] = []
    @Published var isLoading: Bool = false
    @Published var isRequestFailed = false
    
    var isAbleToLoadMore: Bool{
        page != nil
    }

    private var moviesRepo: MoviesRepository
    private var page: Int?

    init(genre: GenreModel, moviesRepo: MoviesRepository){
        self.genre = genre
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
        getMovies(page: page)
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
    
    private func getMovies(page: Int){
        moviesRepo.search(criteria: .genres(data: [genre]), page: page, response: { [weak self] data, error in
            self?.handleResponse(usingData: data, error: error, page: page)
        })
    }
    
}
