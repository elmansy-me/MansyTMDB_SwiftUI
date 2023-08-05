//
//  HomeMovieView.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 02/08/2023.
//

import SwiftUI
import MansyTMDBCore

struct HomeMovieView: View {
    
    private let data: BaseMovieModel
    
    init(data: BaseMovieModel) {
        self.data = data
    }
    
    var body: some View {
        VStack(spacing: 10){
            BuildImage(withURL: data.imageURL(quality: .thumbnail), width: 140, height: 140)
                .frame(width: 140, height: 140)
            VStack(alignment: .leading) {
                Text(data.title ?? "")
                    .fontWeight(.bold)
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
        .frame(width: 140, height: 225)
        .cornerRadius(4)
        .clipped()
    }
}

struct HomeMovieView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMovieView(data: .mocked)
    }
}
