//
//  LoadingDialog.swift
//  Yelp Business
//
//  Created by mmbs on 21/05/23.
//

import SwiftUI

struct LoadingDialog: View {
    
    @Binding var message: String
    
    var body: some View {
        VStack(spacing: 10) {
            if #available(iOS 14.0, *) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                ActivityIndicator(isAnimating: true)
            }
            Text(message)
        }
        .padding()
        .cornerRadius(20)
    }
}

struct ActivityIndicator: UIViewRepresentable {
    public typealias UIView = UIActivityIndicatorView
    public var isAnimating: Bool = true
    public var configuration = { (indicator: UIView) in }
    
    public init(isAnimating: Bool, configuration: ((UIView) -> Void)? = nil) {
        self.isAnimating = isAnimating
        if let configuration = configuration {
            self.configuration = configuration
        }
    }
    
    public func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView {
        UIView()
    }
    
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}

extension View where Self == ActivityIndicator {
    func configure(_ configuration: @escaping (Self.UIView) -> Void) -> Self {
        Self.init(isAnimating: self.isAnimating, configuration: configuration)
    }
}
