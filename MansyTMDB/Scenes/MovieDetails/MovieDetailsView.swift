//
//  MovieDetailsView.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 04/08/2023.
//

import SwiftUI
import MansyTMDBCore

struct MovieDetailsView: View {
    
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        ContentView()
            .navigationTitle(viewModel.movie?.title ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .padding(0)
            .onAppear {
                viewModel.getData()
            }
    }
}

extension MovieDetailsView{
    
    @ViewBuilder
    private func ContentView()->some View{
        if let movie = viewModel.movie{
            DetailsView(movie: movie)
        }else if viewModel.isLoading{
            LoadingView()
        }else if let error = viewModel.error{
            ErrorView(message: error)
        }else{
            ErrorView(message: "Undefined error")
        }
        
    }
    
    @ViewBuilder
    private func DetailsView(movie: MovieModel)->some View{
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16){
                BuildImage(withURL: movie.imageURL(quality: .medium), height: 300)
                    .frame(height: 300)
                VStack(alignment: .leading, spacing: 16) {
                    Text(movie.title ?? (movie.original_title ?? ""))
                        .font(.title)
                        .bold()
                    TitleValueRowView(
                        title: "Vote Count:",
                        value: .number(movie.vote_count)
                    )
                    TitleValueRowView(
                        title: "Vote Average:",
                        value: .rating(movie.vote_average)
                    )
                    TitleValueRowView(
                        title: "Adults only:",
                        value: .text(movie.adult ? "Yes" : "No")
                    )
                    TitleValueRowView(
                        title: "Release Date:",
                        value: .text(movie.release_date)
                    )
                    TitleValueRowView(
                        title: "Status:",
                        value: .text(movie.status)
                    )
                    if !movie.production_companies.isEmpty{
                        Divider()
                        MovieDetailsProductionCompaniesListView(list: movie.production_companies)
                    }
                    Divider()
                    
                    Text("Overview:")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .underline()
                    Text(movie.overview ?? "")
                        .italic()
                }.padding()
            }
            .padding(0)
        }
    }
    
    
    @ViewBuilder
    private func TitleValueRowView(title: String, value: ValueType)-> some View{
        HStack {
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
            Spacer()
            switch value {
            case .text(let text):
                Text(text ?? "N/A")
                    .font(.caption)
            case .number(let number):
                Text(String(describing: number))
                    .font(.caption)
            case .rating(let rate):
                RateView(rating: rate)
            }
        }
    }
    
}

private enum ValueType{
    case text(_ text: String?)
    case number(_ number: Int)
    case rating(_ rate: Double)
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(viewModel: .init(movieId: 238, repo: .init()))
    }
}
