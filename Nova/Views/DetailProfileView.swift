import SwiftUI
import Kingfisher

struct DetailProfileView: View {
    let myAPI = API()
    @ObservedObject var account = AccountModel(myAPI: API())
    @ObservedObject var list = ListModel(myAPI: API())

    var body: some View {
        NavigationStack{
            
            ZStack{
                Color("backgroundColor").ignoresSafeArea()
                VStack(alignment: .leading){
                    HStack(alignment: .top){
                        VStack{
                            KFImage(Foundation.URL(string: account.account?.data.icon_img ?? "")).roundCorner(radius: .widthFraction(0.5)).placeholder {
                                Image(systemName: "arrow.2.circlepath.circle")
                                    .font(.largeTitle)
                                    .opacity(0.3)
                            }.retry(maxCount: 3, interval: .seconds(5)).resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
                            Text(account.account?.data.name ?? "novalue").bold()
                        }.padding()
                        VStack(alignment: .leading, spacing: 8){
                            Text("")
                            Text("Total comment karma: " + String((account.account?.data.comment_karma ?? 0))).italic()
                            Text("Total post karma: " + String((account.account?.data.link_karma ?? 0))).italic()
                            Spacer()
                        }.padding()
                    }.padding()
                    Spacer()
                }
                
//                List(list.posts){ post in
//                    Section(header: Spacer(minLength: 0)){
//                        PostsView(post: post)
//                    }
//                }.scrollContentBackground(.hidden).listStyle(.grouped)
                
            }.navigationTitle("Profile").toolbarBackground(Color("navigationColor"), for: .navigationBar).toolbarBackground(.visible, for: .navigationBar).onAppear(perform: fetchAccount)
        }
        
        
    }
    private func fetchAccount() {
        account.fetchAccount()
//        list.fetchListing(for: "user/I_Love_Swift.json")
    }
}

