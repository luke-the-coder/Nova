import Foundation
import SwiftUI
struct mainView: View{
    let myAPI = API()
    @ObservedObject var list = ListModel(myAPI: API())
    var body: some View {
        
        NavigationStack{
                List(list.posts){ post in
                    
                    Section(header: Spacer(minLength: 0)){
                        
                        VStack(alignment: .leading){
                            
                            Text(post.title).bold()
                            Text("u/" + post.author).italic()
                            AsyncImage(url: URL(string: post.url), content: { image in
                                image.resizable().aspectRatio(contentMode: .fit)//.frame(maxWidth: 300, maxHeight: 100)
                            },
                            placeholder: {
                                Text("loading")
                            })

                        }
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
