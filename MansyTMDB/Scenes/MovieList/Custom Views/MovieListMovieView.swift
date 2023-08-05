//
//  MovieListMovieView.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 03/08/2023.
//

import SwiftUI
import MansyTMDBCore

struct MovieListMovieView: View {
    
    private let data: BaseMovieModel
    
    init(data: BaseMovieModel) {
        self.data = data
    }
    
    var body: some View {
        HStack(spacing: 10){
            BuildImage(withURL: data.imageURL(quality: .thumbnail), width: 90, height: 90)
                .frame(width: 90, height: 90)
                .cornerRadius(4)
            VStack(alignment: .leading) {
                Text(data.title ?? "")
                    .fontWeight(.bold)
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Text(data.overview ?? "")
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Spacer()
                HStack{
                    Spacer()
                    RateView(rating: data.vote_average)
                        .padding([.bottom], 4)
                }
            }
            .padding([.leading, .trailing], 4)
        }
        .background(Color(.systemBackground))
        .frame(height: 90)
        .cornerRadius(4)
        .clipped()
    }
}

struct MovieListMovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListMovieView(data: .mocked)
    }
}
