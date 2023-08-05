//
//  GenreMovieListViewModelTests.swift
//  MansyTMDBTests
//
//  Created by Ahmed Elmansy on 05/08/2023.
//

import XCTest
@testable import MansyTMDB
@testable import MansyTMDBCore


final class GenreMovieListViewModelTests: XCTestCase {
    
    private var moviesRepo: MockMoviesRepository!
    var genreModel: GenreModel!
    var viewModel: GenreMovieListViewModel!
    
    override func setUp() {
        super.setUp()
        moviesRepo = MockMoviesRepository()
        genreModel = GenreModel(id: 1, name: "Action")
        viewModel = GenreMovieListViewModel(genre: genreModel, moviesRepo: moviesRepo)
    }
    
    override func tearDown() {
        moviesRepo = nil
        genreModel = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testGetData() {
        // Given
        let list = BaseMovieModel.mockedList
        moviesRepo.list = list
        
        // When
        viewModel.getData()
        
        // Then
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching data")
        XCTAssertFalse(viewModel.isRequestFailed, "isRequestFailed should be false when the request is successful")
        XCTAssertEqual(viewModel.list, list, "List should match the data returned from the repository")
    }
    
    func testGetDataWithEmptyResult() {
        // Given
        let list: [BaseMovieModel] = []
        moviesRepo.list = list
        
        // When
        viewModel.getData()
        
        // Then
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching data")
        XCTAssertFalse(viewModel.isRequestFailed, "isRequestFailed should be false when the request is successful")
        XCTAssertEqual(viewModel.list, list, "List should match the data returned from the repository")
    }
    
    func testGetDataWithError() {
        // Given
        let error = "An error occurred"
        moviesRepo.list = nil
        moviesRepo.error = error
        
        // When
        viewModel.getData()
        
        // Then
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching data")
        XCTAssertTrue(viewModel.isRequestFailed, "isRequestFailed should be true when the request returns an error")
        XCTAssertEqual(viewModel.error, error, "Error message should match the error returned from the repository")
    }
    
}

// Mock MoviesRepository for testing
private class MockMoviesRepository: MoviesRepository {
    
    var list: [BaseMovieModel]?
    var error: String?
    
    override func search(criteria: MovieSearchCriteria, page: Int, response: @escaping MoviesResponse) {
        response(list, error)
    }
    
}
