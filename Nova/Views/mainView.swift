import Foundation
import SwiftUI
import AVKit
struct mainView: View{
    let myAPI = API()
    @ObservedObject var list = ListModel(myAPI: API())
    var body: some View {
        
        NavigationStack{
                List(list.posts){ post in
                    Section(header: Spacer(minLength: 0)){
                        PostsView(post: post)
                    }
                    
                }.navigationTitle("r/all").toolbarBackground(Color.blue, for: .navigationBar).toolbarBackground(.visible, for: .navigationBar)
                
            }.onAppear(perform: fetchListing)
            
        
    }
    private func fetchListing() {
        list.fetchListing()
    }
}

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
