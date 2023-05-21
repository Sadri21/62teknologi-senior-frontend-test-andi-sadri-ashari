//
//  BorderView.swift
//  Yelp Business
//
//  Created by mmbs on 21/05/23.
//

import SwiftUI

struct BorderView: ViewModifier {
    @State var paddingVertical : CGFloat = 16
    @State var paddingHorizontal : CGFloat = 16
    @State var cornerRadii : CGFloat
    @State var lineWidht: CGFloat
    @State var backgroundColor: Color
    
    func body(content: Content) -> some View {
        return content
            .padding(.vertical, paddingVertical)
            .padding(.horizontal, paddingHorizontal)
            .overlay(RoundedRectangle(cornerRadius: cornerRadii).stroke(Color("light-grey") ,lineWidth: lineWidht))
            .background(backgroundColor.cornerRadius(cornerRadii))
    }
}


extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}


struct CardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.gray)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 4)
    }
}

//extension String {
//    var html2AttributedString: NSAttributedString? {
//        Data(utf8).html2AttributedString
//    }
//    var html2String: String {
//        html2AttributedString?.string ?? ""
//    }
//}

//extension Data {
//    var html2AttributedString: NSAttributedString? {
//        do {
//            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
//        } catch {
//            print("error:", error)
//            return  nil
//        }
//    }
//    var html2String: String { html2AttributedString?.string ?? "" }
//}
