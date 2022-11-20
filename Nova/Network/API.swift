import Foundation
class API{
    func callAPI(completion: @escaping (Result<[Post], Error>) -> Void){
        guard let url = URL(string: "https://www.reddit.com/r/all.json?limit=10") else {
            print("ERROR")
            return;
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            
            let decoder = JSONDecoder()
            do{
                let data = data ?? Data()
                let tasks = try decoder.decode(Listing.self, from: data)
                //print(tasks.posts[23].media?.reddit_video?.fallback_url)
                completion(.success(tasks.posts))

            }catch{
                completion(.failure(error))
                print(error)
            }
        }.resume()
    }
    
}
