import Foundation
class API{
    init() {
        //callAPI()
    }
    func callAPI(completion: @escaping (Result<[Post], Error>) -> Void){
        guard let url = URL(string: "https://www.reddit.com/r/all.json") else {
            print("ERROR")
            return;
        }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            
            let decoder = JSONDecoder()
            do{
                let data = data ?? Data()
                print(data)
                let tasks = try decoder.decode(Listing.self, from: data)
                
                print(tasks.posts[0].title)
                completion(.success(tasks.posts))

            }catch{
                completion(.failure(error))
                print(error)
            }
        }.resume()
    }
    
}
