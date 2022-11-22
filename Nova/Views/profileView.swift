
import Foundation
import SwiftUI

struct profileView: View{
    let logg = ViewController()
    
    var body: some View {
        NavigationStack{
            
            VStack{
            }.navigationTitle("MyApp").onAppear(perform: startt)
        }
    }
    private func startt(){
        logg.startSignIn()
    }
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
