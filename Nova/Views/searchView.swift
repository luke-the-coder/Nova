
import Foundation
import SwiftUI

struct searchView: View{
    @ObservedObject var list = ListModel(myAPI: API())

    @State private var query = ""
    @State private var subredditTitle = "r/all"
    
    var body: some View {
        NavigationStack{
            
            ZStack{
                Color("LightCyan").ignoresSafeArea()
                VStack{
                    TextField("Search Subreddit", text: self.$query) {
                        self.subredditTitle = "r/\(self.query.lowercased())"
                        self.fetchListing()
                    }
                    
                }
                
            }.navigationBarTitle("Search")
        }.onAppear(perform: fetchListing)
    }
    private func fetchListing() {
        list.fetchListing()
    }
}

struct searchView_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
