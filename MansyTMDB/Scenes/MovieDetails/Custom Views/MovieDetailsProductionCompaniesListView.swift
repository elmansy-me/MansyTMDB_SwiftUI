//
//  MovieDetailsProductionCompaniesListView.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 05/08/2023.
//

import SwiftUI
import MansyTMDBCore

struct MovieDetailsProductionCompaniesListView: View {
    
    let list: [ProductionCompanyModel]
    
    var body: some View {
        Section{
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(list, id: \.id) { data in
                        MovieDetailsProductionCompanyView(data: data)
                    }
                }
                .padding(16)
            }
            .listRowInsets(EdgeInsets())
        } header: {
            Text("Production Companies")
                .underline()
                .font(.subheadline)
                .fontWeight(.bold)
        }
    }
}
