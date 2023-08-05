//
//  MovieDetailsProductionCompanyView.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 05/08/2023.
//

import SwiftUI
import MansyTMDBCore

struct MovieDetailsProductionCompanyView: View {
    
    let data: ProductionCompanyModel
    
    var body: some View {
        VStack(spacing: 8) {
            BuildImage(withURL: data.imageURL(quality: .small), width: 50, height: 50)
                .frame(width: 50, height: 50)
                .cornerRadius(25)
            Text(data.name ?? "N/A")
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(width: 80)
        .padding()
    }
}
