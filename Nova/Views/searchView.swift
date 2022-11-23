
import Foundation
import SwiftUI

struct searchView: View{
    @ObservedObject var list = ListModel(myAPI: API())
    let api : API
    //@State private var request = ""
    @Binding var request : String


    var body: some View {
        NavigationStack{
            
            ZStack{
                Color("backgroundColor").ignoresSafeArea()
                VStack{
                    TextField("Search Subreddit", text: self.$request) {
                        
                        self.fetchListing()
                    }.padding().textFieldStyle(.roundedBorder)
                    
                    
//                    Button(action: api.getMe()){
//                        Text("Just do it")
//                    }
                    Spacer()
                }
                
                
            }.navigationBarTitle("Search").toolbarBackground(Color("navigationColor"), for: .navigationBar).toolbarBackground(.visible, for: .navigationBar)
        }.onAppear(perform: fetchListing)
    }
    private func fetchListing() {
        list.fetchListing(for: request)
    }
}

//struct searchView_Previews: PreviewProvider {
//    static var previews: some View {
//        mainView()
//    }
//}
