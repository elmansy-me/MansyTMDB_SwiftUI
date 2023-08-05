//
//  ErrorView.swift
//  MansyTMDB
//
//  Created by Ahmed Elmansy on 04/08/2023.
//

import SwiftUI

struct ErrorView: View {
    
    let message: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Oops ...")
                .bold()
            Text(message)
                .italic()
        }.padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: "Sample message")
    }
}
