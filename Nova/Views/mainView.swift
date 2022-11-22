import Foundation
import SwiftUI
import AVKit
struct mainView: View{
    let myAPI = API()
    @State private var request = ""
    @ObservedObject var list = ListModel(myAPI: API())
    var body: some View {
        
        NavigationStack{
            ZStack{
                Color("LightCyan").ignoresSafeArea()
                List(list.posts){ post in
                    Section(header: Spacer(minLength: 0)){
                        PostsView(post: post)
                    }
                }.scrollContentBackground(.hidden).listStyle(.grouped)
                
            }.navigationTitle("r/all").toolbarBackground(Color("pacificBlue"), for: .navigationBar).toolbarBackground(.visible, for: .navigationBar).onAppear(perform: fetchListing)
        }
        
    }
    private func fetchListing() {
        list.fetchListing(for: request)
    }
}

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
