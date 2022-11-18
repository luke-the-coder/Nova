import Foundation
import SwiftUI

class ListModel: ObservableObject {
    let myAPI: API
    @Published var posts = [Post]()
    
    init(myAPI: API) {
        self.myAPI = myAPI
    }
    
    func fetchListing() {
        myAPI.callAPI() {  [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    
                    self?.posts = posts
                    print(self?.posts)
                case .failure:
                    print("NO")
                    self?.posts = []
                }
            }
        }
    }
}
