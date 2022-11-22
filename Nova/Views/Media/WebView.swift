import SwiftUI
import Foundation
import WebKit

struct WebConnect: UIViewRepresentable {
    let request: URLRequest
    
    func makeUIView(context: UIViewRepresentableContext<WebConnect>) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebConnect>) {
        uiView.load(request)
    }
}

struct WebView: View{
    var URL : String
    var body : some View{
        NavigationLink(destination: WebConnect(request: URLRequest(url: Foundation.URL(string: URL)!))){
            HStack{
                Image(systemName: "personalhotspot.circle" )
                Text(URL)
            }
        }
    }
}
