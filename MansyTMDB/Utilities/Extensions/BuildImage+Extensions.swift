//
//  BuildImage+Extensions.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 04/08/2023.
//

import SwiftUI
import CachedAsyncImage

extension View{
    
    @ViewBuilder
    func BuildImage(withURL url: String, width:CGFloat? = nil, height:CGFloat? = nil)->some View{
        CachedAsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
        }.frame(
            width: width,
            height: height,
            alignment: .center
        )
        .clipped()
    }
    
}
