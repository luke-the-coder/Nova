import Foundation
class API{
    func callAPI(for request: String, completion: @escaping (Result<[Post], Error>) -> Void){
        let trimPath = request.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = URL(string: "https://www.reddit.com/\(trimPath.count == 0 ? "" : "r/\(trimPath)").json") else {
            preconditionFailure("Failed to construct search URL for query: \(request)")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            
            let decoder = JSONDecoder()
            do{
                let data = data ?? Data()
                let tasks = try decoder.decode(Listing.self, from: data)
                //print(tasks.posts[23].media?.reddit_video?.fallback_url)
                print(tasks.after)
                
                completion(.success(tasks.posts))
                
            }catch{
                completion(.failure(error))
                print(error)
            }
        }.resume()
    }
    
    func getMe(){
        print("Hel!")
        guard let url = URL(string: "https://oauth.reddit.com/api/v1/me") else {return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let json: [String: Any] = ["State": 1]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let token =  UserDefaults.standard.string(forKey: "token")
        print("Hello?")
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        //    func sendReq(completion: @escaping (Result<[Post], Error>) -> Void){
        //        guard let url = URL(string: "https://www.reddit.com/r/all.json?limit=80") else {
        //            print("ERROR")
        //            return;
        //        }
        //        var request = URLRequest(url: url)
        //        request.httpMethod = "GET"
        //
        //        URLSession.shared.dataTask(with: request){ data, response, error in
        //
        //            let decoder = JSONDecoder()
        //            do{
        //                let data = data ?? Data()
        //                let tasks = try decoder.decode(Listing.self, from: data)
        //                //print(tasks.posts[23].media?.reddit_video?.fallback_url)
        //                completion(.success(tasks.posts))
        //
        //            }catch{
        //                completion(.failure(error))
        //                print(error)
        //            }
        //        }.resume()
        //    }
        
    }
}
