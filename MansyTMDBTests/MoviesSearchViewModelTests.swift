//
//  MoviesSearchViewModelTests.swift
//  MansyTMDBTests
//
//  Created by Ahmed Elmansy on 05/08/2023.
//

import XCTest
import Combine
@testable import MansyTMDB
@testable import MansyTMDBCore

final class MoviesSearchViewModelTests: XCTestCase {
    
    var viewModel: MoviesSearchViewModel!
    private var moviesRepo: MockMoviesRepository!
    
    override func setUp() {
        super.setUp()
        moviesRepo = MockMoviesRepository()
        viewModel = MoviesSearchViewModel(repo: moviesRepo)
    }
    
    override func tearDown() {
        viewModel = nil
        moviesRepo = nil
        super.tearDown()
    }
    
    func testSearchQuery() {
        // Given
        let query = "Spider Man"
        
        // When
        viewModel.searchQuery = query
        
        // Then
        XCTAssertEqual(viewModel.searchQuery, query, "Search query should be set correctly")
    }
    
    func testResetAll() {
        // Given
        viewModel.list = BaseMovieModel.mockedList
        viewModel.state = .dataAvailable
        
        // When
        viewModel.resetAll()
        
        // Then
        XCTAssertTrue(viewModel.list.isEmpty, "The list should be empty after reset")
        XCTAssertEqual(viewModel.state, .waiting, "The state should be set to waiting after reset")
    }
    
    func testGetSearchResultsWithData() {
        // Given
        let searchResults = BaseMovieModel.mockedList
        moviesRepo.searchResults = searchResults
        
        // When
        viewModel.searchQuery = "Spider Man"
        
        // Then
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching data")
        XCTAssertEqual(viewModel.list, searchResults, "Search results should match the data returned from the repository")
        XCTAssertEqual(viewModel.state, .dataAvailable, "State should be set to dataAvailable when results are available")

    }
    
    func testGetSearchResultsWithEmptyData() {
        // Given
        moviesRepo.searchResults = []
        
        // When
        viewModel.searchQuery = "Spider Man With No Results"
        
        // Then
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching data")
        XCTAssertTrue(viewModel.list.isEmpty, "The list should be empty when no results are available")
        XCTAssertEqual(viewModel.state, .noResults, "State should be set to noResults when no results are available")

    }
    
    func testGetSearchResultsWithError() {
        // Given
        let error = "An error occurred"
        moviesRepo.error = error
        moviesRepo.searchResults = nil
        
        // When
        viewModel.searchQuery = "Spider Man"
        
        // Then
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching data")
        XCTAssertNotNil(viewModel.error, "An error should be set after the request fails")
        XCTAssertEqual(viewModel.state, .error(error), "State should be set to error when the request fails")

    }
}

// Mock MoviesRepository
private class MockMoviesRepository: MoviesRepository {
    var searchResults: [BaseMovieModel]?
    var error: String?
    
    override func search(criteria: MovieSearchCriteria, page: Int, response: @escaping MoviesResponse) {
        response(searchResults, error)
    }
}
