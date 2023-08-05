//
//  LoadingView.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 04/08/2023.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        ProgressView("Loading ...")
            .foregroundColor(Color(.label))
            .padding()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
