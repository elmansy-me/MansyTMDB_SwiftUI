//
//  RateView.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 03/08/2023.
//

import SwiftUI

struct RateView: View {
    
    let rating: Double
    
    var body: some View {
        HStack {
            Text("\(rating, specifier: "%.1f")")
                .font(.caption)
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
        }
    }
}

struct RateView_Previews: PreviewProvider {
    static var previews: some View {
        RateView(rating: 4.5)
    }
}
