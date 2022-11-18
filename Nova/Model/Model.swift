import Foundation

protocol Model: Identifiable, Decodable {}

struct Listing {
    var posts = [Post]() //children
}

struct Post: Model {
    let id: String
    let title: String
    let author: String
    let url: String
    let subreddit: String
//    let media : Media
}
//
//struct Media: Decodable {
//    let video : Video
//}
//struct Video : Decodable{
//    let fallback_url : String
//}
//
//extension Media {
//    enum CodingKeys : String, CodingKey{
//        case video
//        case data
//    }
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
//        video = try dataContainer.decode(Video.self, forKey: .video)
//    }
//}
//extension Video {
//    enum CodingKeys : String, CodingKey{
//        case fallback_url
//        case data
//    }
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
//        fallback_url = try dataContainer.decode(String.self, forKey: .fallback_url)
//    }
//}
extension Post: Decodable {
    enum CodingKeys: String, CodingKey{
        case id, title, author, url, media
        case subreddit = "subreddit_name_prefixed"
        case data
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)

        id = try dataContainer.decode(String.self, forKey: .id)
        title = try dataContainer.decode(String.self, forKey: .title)
        author = try dataContainer.decode(String.self, forKey: .author)
        url = try dataContainer.decode(String.self, forKey: .url)
        subreddit = try dataContainer.decode(String.self, forKey: .subreddit)
//        media = try dataContainer.decode(Media.self, forKey: .media)
    }
}

extension Listing: Decodable {
    enum CodingKeys: String, CodingKey {
        case posts = "children"

        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let data = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)

        posts = try data.decode([Post].self, forKey: .posts)
    }
}

//non funziona
//import Foundation
//protocol Model: Identifiable, Decodable {}
//struct Root : Codable {
//    let kind : String
//    var root = [DataContent]()
//}
//
//struct DataContent : Codable{
//    var children = [Post]()
//}
//struct Post : Codable{
//    let kind : String
//    var data = [PostDetail]()
//}
//struct PostDetail : Codable{
//    let id: String
//    let title: String
//    let author: String
//    let url: String
//    let subreddit_name_prefixed: String
//}
