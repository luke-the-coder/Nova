import Foundation
import SwiftUI

class ListModel: ObservableObject {
    let myAPI: API
    @Published var posts = [Post]()
    
    init(myAPI: API) {
        self.myAPI = myAPI
    }
    
    func fetchListing(for request: String) {
        myAPI.getJSON(for: request) {  [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self?.posts = posts
                case .failure:
                    self?.posts = []
                }
            }
        }
    }
}

