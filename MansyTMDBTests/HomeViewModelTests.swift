//
//  HomeViewModelTests.swift
//  MansyTMDBTests
//
//  Created by Ahmed Elmansy on 05/08/2023.
//

import XCTest
import Combine
@testable import MansyTMDB
@testable import MansyTMDBCore

final class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    private var moviesRepo: MockMoviesRepository!
    private var genresRepo: MockGenresRepository!
    
    override func setUp() {
        super.setUp()
        moviesRepo = MockMoviesRepository()
        genresRepo = MockGenresRepository()
        viewModel = HomeViewModel(moviesRepo: moviesRepo, genresRepo: genresRepo)
    }
    
    override func tearDown() {
        viewModel = nil
        moviesRepo = nil
        genresRepo = nil
        super.tearDown()
    }
    
    func testGetData() {
        // Given
        let genres = [GenreModel(id: 1, name: "Action")]
        let popularMovies = BaseMovieModel.mockedList
        let topRatedMovies = BaseMovieModel.mockedList
        let upcomingMovies = BaseMovieModel.mockedList
        
        self.genresRepo.genres = genres
        self.moviesRepo.popularMovies = popularMovies
        self.moviesRepo.topRatedMovies = topRatedMovies
        self.moviesRepo.upcomingMovies = upcomingMovies
        
        // When
        viewModel.getData()
        
        // Then
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching data")
        XCTAssertEqual(viewModel.genres, genres, "Genres should match the data returned from the repository")
        XCTAssertEqual(viewModel.popularMovies, popularMovies, "Popular movies should match the data returned from the repository")
        XCTAssertEqual(viewModel.topRatedMovies, topRatedMovies, "Top rated movies should match the data returned from the repository")
        XCTAssertEqual(viewModel.upcomingMovies, upcomingMovies, "Upcoming movies should match the data returned from the repository")
    }
    
}


// Mock MoviesRepository
private class MockMoviesRepository: MoviesRepository {
    var popularMovies: [BaseMovieModel]?
    var topRatedMovies: [BaseMovieModel]?
    var upcomingMovies: [BaseMovieModel]?
    
    override func popular(page: Int, response: @escaping MoviesResponse) {
        response(popularMovies, nil)
    }
    
    override func topRated(page: Int, response: @escaping MoviesResponse) {
        response(topRatedMovies, nil)
    }
    
    override func upcoming(page: Int, response: @escaping MoviesResponse) {
        response(upcomingMovies, nil)
    }
}


// Mock GenresRepository
private class MockGenresRepository: GenresRepository {
    var genres: [GenreModel]?
    
    override func moviesGenres(response: @escaping Response) {
        response(genres, nil)
    }
}
