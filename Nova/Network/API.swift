import Foundation
class API{
    func getJSON(for request: String, completion: @escaping (Result<[Post], Error>) -> Void){
        let token =  UserDefaults.standard.string(forKey: "token")
        let trimPath = request.trimmingCharacters(in: .whitespacesAndNewlines)
        var subdomain : String
    
        if (token != nil){
            subdomain = "oauth"
        } else {
            subdomain = "www"
        }
        print (trimPath)
        print (subdomain)
        guard let url = URL(string: "https://\(subdomain).reddit.com/\(trimPath).json?limit=100") else {
            preconditionFailure("Failed to construct search URL for query: \(request)")
        }
        print(url)
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        if (token != nil){
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
            request.setValue( "Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        }
        URLSession.shared.dataTask(with: request){ data, response, error in
            
            let decoder = JSONDecoder()
            do{
                let data = data ?? Data()
                let tasks = try decoder.decode(Listing.self, from: data)
                //print(tasks.posts[23].media?.reddit_video?.fallback_url)
                
                completion(.success(tasks.posts!))
                
            }catch{
                completion(.failure(error))
                print(error)
            }
        }.resume()
    }
    
    func getAccountData(completion: @escaping (Result<Welcome, Error>) -> Void){
        guard let url = URL(string: "https://oauth.reddit.com/user/I_Love_Swift/about.json") else { return }
        let token =  UserDefaults.standard.string(forKey: "token")

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            let decoder = JSONDecoder()
            do{
                let data = data ?? Data()
                let json = try decoder.decode(Welcome.self, from: data)
                print(json)
                completion(.success(json))
            }catch{
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
    
    func postAPICall(for fullname: String, for upvote: String){
        //Parameters
        var requestBodyComponents = URLComponents()
        print(fullname)
        print(upvote)
        requestBodyComponents.queryItems = [URLQueryItem(name: "id", value: fullname),
                                            URLQueryItem(name: "dir", value: upvote)]
        let url = URL(string: "https://oauth.reddit.com/api/vote")!
        
        //create the session object
        let session = URLSession.shared
        
        //now create the Request object using the url object
        let token =  UserDefaults.standard.string(forKey: "token")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        
        //set body with parameters
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
//            print(error)
//            print(data)
//            print(response)
        })
        task.resume()
        
    }
}

