import SwiftUI

@main
struct NovaApp: App {
    let myAPI = API()
    @ObservedObject var list = ListModel(myAPI: API())
    var body: some Scene {
        WindowGroup {
            TabView{
                mainView().tabItem{
                    Label("Feed", systemImage: "newspaper.circle.fill")
                }
                searchView(api: API()).tabItem{
                    Label("Search", systemImage: "magnifyingglass.circle.fill")
                }
                profileView().tabItem{
                    Label("Profile", systemImage: "person.circle.fill")
                }
            }
        }
    }
}
