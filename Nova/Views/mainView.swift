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
                }.scrollContentBackground(.hidden).listStyle(.grouped).cornerRadius(10)
                
            }.navigationTitle(request).toolbarBackground(Color("navigationColor"), for: .navigationBar).toolbarBackground(.visible, for: .navigationBar).onAppear(perform: fetchListing)
        }
        
    }
    private func fetchListing() {
        list.fetchListing(for: request)
    }
}

