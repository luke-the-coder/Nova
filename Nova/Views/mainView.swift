import Foundation
import SwiftUI
import AVKit
struct mainView: View{
    let myAPI = API()
    @Binding var request : String
    @ObservedObject var list = ListModel(myAPI: API())
    var body: some View {
        
        NavigationStack{
            ZStack{
                Color("backgroundColor").ignoresSafeArea()
                List(list.posts){ post in
                    Section(header: Spacer(minLength: 0)){
                        PostsView(post: post)
                    }
                }.scrollContentBackground(.hidden).listStyle(.grouped)
                
            }.navigationTitle("r/" + request).toolbarBackground(Color("navigationColor"), for: .navigationBar).toolbarBackground(.visible, for: .navigationBar).onAppear(perform: fetchListing)
        }
        
    }
    private func fetchListing() {
        list.fetchListing(for: request)
    }
}

//struct mainView_Previews: PreviewProvider {
//    static var previews: some View {
//        mainView()
//    }
//}

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
