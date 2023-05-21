//
//  CategoryView.swift
//  Yelp Business
//
//  Created by mmbs on 21/05/23.
//

import SwiftUI

struct CategoryView: View {
    
    @State var text = "seafood"
    
    var body: some View {
        Text(text)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .overlay(
                Capsule(style: .continuous)
                    .stroke(Color("primary"), lineWidth: 1)
            )
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
