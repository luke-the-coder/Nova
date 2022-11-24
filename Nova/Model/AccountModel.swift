import Foundation
import SwiftUI

class AccountModel: ObservableObject {
    let myAPI: API
    @Published var account : Welcome?
    
    init(myAPI: API) {
        self.myAPI = myAPI
    }
    
    func fetchAccount() {
        myAPI.getAccountData() {  [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let accountGet):
                    self?.account = accountGet
                case .failure:
                    print("error")
                }
            }
        }
    }
}

