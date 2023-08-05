//
//  MovieDetailsViewModelTests.swift
//  MansyTMDBTests
//
//  Created by Ahmed Elmansy on 05/08/2023.
//

import XCTest
import Combine
@testable import MansyTMDB
@testable import MansyTMDBCore

final class MovieDetailsViewModelTests: XCTestCase {
    
    var viewModel: MovieDetailsViewModel!
    private var movieRepo: MockMovieRepository!
    
    override func setUp() {
        super.setUp()
        movieRepo = MockMovieRepository()
        viewModel = MovieDetailsViewModel(movieId: 123, repo: movieRepo)
    }
    
    override func tearDown() {
        viewModel = nil
        movieRepo = nil
        super.tearDown()
    }
    
    func testGetData() {
        // Given
        let movieDetails = MovieModel(id: 123, vote_count: 100, title: "Movie", original_title: "Original Title", poster_path: "/path/to/image.jpg", overview: "Overview", release_date: "2023-08-05", status: "Released", vote_average: 7, genres: [], adult: false, production_companies: [])
        movieRepo.movieDetails = movieDetails

        // When
        viewModel.getData()
       
        // Then
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching data")
        XCTAssertEqual(viewModel.movie, movieDetails, "Movie details should match the data returned from the repository")

    }
    
    func testGetDataWithError() {
        // Given
        let error = "An error occured"
        movieRepo.movieDetails = nil
        movieRepo.error = error

        // When
        viewModel.getData()
        
        // Then
        XCTAssertFalse(self.viewModel.isLoading, "isLoading should be false after fetching data")
        XCTAssertEqual(self.viewModel.error, error, "Error message should match the error returned from the repository")

    }
}


// Mock MovieRepository
private class MockMovieRepository: MovieRepository {
    var movieDetails: MovieModel?
    var error: String?
    
    override func details(id: Int, response: @escaping MovieResponse) {
        response(movieDetails, error)
    }
}
