//
//  ContentView.swift
//  NewsReader
//
//  Created by Adam Lea on 3/11/21.
//

import SwiftUI
import URLImage

struct Result: Codable {
    var articles: [Article]
}

struct Article: Codable {
    var url: String
    var title: String
    var description: String?
    var urlToImage: String?
}



struct ContentView: View {
    private let url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=4d28f8ee0b8547a38f797128a567e5b1"

    @State private var articles = [Article]()
    
    func fetchData() {
        guard let url = URL(string: url) else {
            print("URL is not valid")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let data = data {
                if let decodedResult = try?
                    JSONDecoder().decode(Result.self, from: data) {
                    DispatchQueue.main.async{
                        self.articles = decodedResult.articles
                    }
                    return
                }
            }
            print("Error: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    var body: some View {
        List(articles, id: \.url) { item in
            HStack(alignment: .top) {
                URLImage(
                    (( URL(string: item.urlToImage ?? "https://picsum.photos/100") ?? nil )!),
                    delay: 0.25,
                    processors: [Resize(size:
                                        CGSize(width: 100.0, height: 100.0),
                                        scale: UIScreen.main.scale)],
                    content: { image in
                        image.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                    }
                ).frame(width: 100.0, height: 100.0)
                
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                    Text(item.description ?? "")
                        .font(.footnote)
                }
            }
            
        }.onAppear(perform: fetchData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
