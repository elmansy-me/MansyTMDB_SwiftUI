//
//  MansyTMDBApp.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 02/08/2023.
//

import SwiftUI
import MansyTMDBCore

@main
struct MansyTMDBApp: App {
    
    init() {
        MansyTMDBCore.configure(APIKey: "c9856d0cb57c3f14bf75bdc6c063b8f3")
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(moviesRepo: MoviesRepository(), genresRepo: GenresRepository()))
        }
    }
}
