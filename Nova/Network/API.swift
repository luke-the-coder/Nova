import Foundation
class API{
    func callAPI(completion: @escaping (Result<[Post], Error>) -> Void){
        guard let url = URL(string: "https://www.reddit.com/r/all.json") else {
            print("ERROR")
            return;
        }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            
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
