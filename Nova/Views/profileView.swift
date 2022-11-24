
import Foundation
import SwiftUI

struct profileView: View{
    @State var loggedin = UserDefaults.standard.bool(forKey: "loggedIn")
    var body: some View {
        NavigationStack{
            
            ZStack{
                Color("backgroundColor").ignoresSafeArea()
                if (loggedin){
                    DetailProfileView()
                } else {
                    LoginView()
                }
            }.navigationTitle("Profile").toolbarBackground(Color("navigationColor"), for: .navigationBar).toolbarBackground(.visible, for: .navigationBar)//.onAppear(perform: startt)
        }
    }

}
