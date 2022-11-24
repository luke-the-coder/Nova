import SwiftUI

struct LoginView : View {
    @ObservedObject private var login = LoginSession()
    @State private var isZoomed = false
    
//    init(){
//        UINavigationBar.setAnimationsEnabled(false)
//    }
    var body: some View{
        NavigationStack{
            ZStack{
                Color("backgroundColor").ignoresSafeArea()
                ZStack{
                    Image(uiImage: UIImage(named: "AppIcon") ?? UIImage()).resizable().scaledToFit().opacity(0.1).frame(width: 350, height: 350).cornerRadius(500).scaleEffect(isZoomed ? 20 : 1)
                        .animation(.easeInOut(duration: 1), value: isZoomed)
                    VStack{
                        Text("It seems you're not logged in!").bold()
                        
                        Text("Please, login with your credentials to fully gain the **Nova** experience.").italic().padding(.top)
                        Button("Login"){
                            isZoomed.toggle()
                            login.startSignIn()
                        }
                    }.padding()
                }
                .navigationTitle("Profile - Login").toolbarBackground(Color("navigationColor"), for: .navigationBar).toolbarBackground(.visible, for: .navigationBar)
                
            }.navigationDestination(isPresented: $login.isLoggedIn){
                DetailProfileView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
        
    
}
