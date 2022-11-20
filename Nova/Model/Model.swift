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
    let media : Media?
    let video : Bool
    let domain : String
    let comments: Int
    let upvote : Int
    let creationTime : Int
}
struct Media: Decodable {
    let type : String?
    let reddit_video : Video?
}
struct Video : Decodable{
    let fallback_url : String?
}

extension Post: Decodable {
    enum CodingKeys: String, CodingKey{
        case id, title, author, url, media, domain
        case subreddit = "subreddit_name_prefixed", video = "is_video", comments = "num_comments", upvote = "ups", creationTime = "created_utc"
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
        media = try dataContainer.decode(Media?.self, forKey: .media)
        video = try dataContainer.decode(Bool.self, forKey: .video)
        domain = try dataContainer.decode(String.self, forKey: .domain)
        comments = try dataContainer.decode(Int.self, forKey: .comments)
        upvote = try dataContainer.decode(Int.self, forKey: .upvote)
        creationTime = try dataContainer.decode(Int.self, forKey: .creationTime)
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
