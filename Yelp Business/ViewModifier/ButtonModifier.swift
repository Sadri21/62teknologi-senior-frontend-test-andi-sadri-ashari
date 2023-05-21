//
//  ButtonModifier.swift
//  Yelp Business
//
//  Created by mmbs on 21/05/23.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    
    @State var widht = 0

    func body(content: Content) -> some View {
        return content
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 16)
            .background(Color("primary"))
            .cornerRadius(15)
            .clipped()
    }
}

struct FlatLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
