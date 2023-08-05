//
//  MoviesSearchViewModel.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 04/08/2023.
//

import Foundation
import Combine
import MansyTMDBCore

class MoviesSearchViewModel: BaseViewModel{
        
    @Published var searchQuery: String
    @Published var list: [BaseMovieModel]
    @Published var isLoading: Bool
    @Published var isRequestFailed: Bool
    @Published var state: State
    
    private var subscriptions: [AnyCancellable]
    
    private var repo: MoviesRepository

    init(repo: MoviesRepository){
        searchQuery = String()
        list = []
        isLoading = false
        isRequestFailed = false
        state = .waiting
        subscriptions = []
        self.repo = repo
        super.init()
        bind()
    }
        
    private func bind(){
        $searchQuery.sink { [weak self] query in
            if query.isEmpty{
                self?.resetAll()
            }else{
                self?.getSearchResults(query: query)
            }
        }.store(in: &subscriptions)
    }
    
    func resetAll(){
        list.removeAll()
        state = .waiting
    }
    
    private func getSearchResults(query: String){
        state = .loading
        isLoading = true
        isRequestFailed = false
        repo.search(criteria: .keyword(data: query), page: 1) { [weak self] data, error in
            self?.isLoading = false
            if let data{
                self?.list = data
                self?.state = data.isEmpty ? .noResults : .dataAvailable
            }else{
                self?.error = error
                self?.isRequestFailed = true
                self?.state = .error(error ?? "Undefined error")
            }
        }
    }
    
}


extension MoviesSearchViewModel{
    
    enum State: Equatable{
        case loading, noResults, dataAvailable, waiting, error(_ message: String)
        
        static func == (lhs: State, rhs: State) -> Bool {
                switch (lhs, rhs) {
                case (.loading, .loading):
                    return true
                case (.noResults, .noResults):
                    return true
                case (.dataAvailable, .dataAvailable):
                    return true
                case (.waiting, .waiting):
                    return true
                case let (.error(lhsMessage), .error(rhsMessage)):
                    return lhsMessage == rhsMessage
                default:
                    return false
                }
            }
    }
    
}
