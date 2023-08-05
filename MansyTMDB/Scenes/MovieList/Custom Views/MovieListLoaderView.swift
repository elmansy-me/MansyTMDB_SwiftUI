//
//  MovieListLoaderView.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 03/08/2023.
//

import SwiftUI

struct MovieListLoaderView: View {
    let isFailed: Bool
    var body: some View {
        Text(isFailed ? "Failed. Tap to retry." : "Loading...")
            .foregroundColor(isFailed ? .red : .green)
            .padding()
    }
}

struct MovieListLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListLoaderView(isFailed: false)
    }
}
