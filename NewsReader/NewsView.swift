//
//  NewsView.swift
//  NewsReader
//
//  Created by Adam Lea on 3/11/21.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}

struct NewsView: View {
    let url: String
    
    var body: some View {
        WebView(request: URLRequest(url: URL(string: url)!))
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(url: "https://www.dummies.com")
    }
}
