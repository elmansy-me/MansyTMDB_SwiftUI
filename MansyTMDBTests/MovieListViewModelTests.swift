//
//  MovieListViewModelTests.swift
//  MansyTMDBTests
//
//  Created by Ahmed Elmansy on 05/08/2023.
//

import XCTest
import Combine
@testable import MansyTMDB
@testable import MansyTMDBCore

final class MovieListViewModelTests: XCTestCase {
    
    var viewModel: MovieListViewModel!
    private var moviesRepo: MockMoviesRepository!
    
    override func setUp() {
        super.setUp()
        moviesRepo = MockMoviesRepository()
        viewModel = MovieListViewModel(section: .popular, moviesRepo: moviesRepo)
    }
    
    override func tearDown() {
        viewModel = nil
        moviesRepo = nil
        super.tearDown()
    }
    
    func testGetData() {
        // Given
        let popularMovies = BaseMovieModel.mockedList
        moviesRepo.popularMovies = popularMovies
        
        // When
        viewModel.getData()
        
        // Then
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching data")
        XCTAssertFalse(viewModel.isRequestFailed, "isRequestFailed should be false when the request is successful")
        XCTAssertEqual(viewModel.list, popularMovies, "List should match the data returned from the repository")
    }
    
    func testGetDataWithError() {
        // Given
        let error = "An error occurred"
        moviesRepo.popularMovies = nil
        moviesRepo.error = error
        
        // When
        viewModel.getData()
        
        // Then
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching data")
        XCTAssertTrue(viewModel.isRequestFailed, "isRequestFailed should be true when the request returns an error")
        XCTAssertEqual(viewModel.error, error, "Error message should match the error returned from the repository")
    }
    
}


// Mock MoviesRepository
private class MockMoviesRepository: MoviesRepository {
    var popularMovies: [BaseMovieModel]?
    var topRatedMovies: [BaseMovieModel]?
    var upcomingMovies: [BaseMovieModel]?
    var error: String?
    
    override func popular(page: Int, response: @escaping MoviesResponse) {
        response(popularMovies, error)
    }
    
    override func topRated(page: Int, response: @escaping MoviesResponse) {
        response(topRatedMovies, error)
    }
    
    override func upcoming(page: Int, response: @escaping MoviesResponse) {
        response(upcomingMovies, error)
    }
}
