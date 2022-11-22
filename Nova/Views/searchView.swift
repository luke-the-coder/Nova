
import Foundation
import SwiftUI

struct searchView: View{
    @ObservedObject var list = ListModel(myAPI: API())
    let api : API
    @State private var request = ""
    @State private var subredditTitle = "r/all"
    
    var body: some View {
        NavigationStack{
            
            ZStack{
                Color("LightCyan").ignoresSafeArea()
                VStack{
                    TextField("Search Subreddit", text: self.$request) {
                        self.subredditTitle = "r/\(self.request.lowercased())"
                        self.fetchListing()
                    }.padding().onAppear(perform: {api.getMe()})
//                    Button(action: api.getMe()){
//                        Text("Just do it")
//                    }
                    Spacer()
                }
                
                
            }.navigationBarTitle("Search")
        }.onAppear(perform: fetchListing)
    }
    private func fetchListing() {
        list.fetchListing(for: request)
    }
}

struct searchView_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
