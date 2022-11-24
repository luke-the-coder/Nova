import SwiftUI

@main
struct NovaApp: App {
    let myAPI = API()
    
    @State private var request : String = "r/all"
    @ObservedObject var list = ListModel(myAPI: API())
    @ObservedObject var account = AccountModel(myAPI: API())

    var body: some Scene {
        WindowGroup {
            TabView{
                mainView(request: $request).tabItem{
                    Label("Feed", systemImage: "newspaper.circle.fill")
                }
                searchView(api: API(), request: $request).tabItem{
                    Label("Search", systemImage: "magnifyingglass.circle.fill")
                }
                profileView().tabItem{
                    Label("Profile", systemImage: "person.circle.fill")
                }
            }
        }
    }
}
