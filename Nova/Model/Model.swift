import Foundation

protocol Model: Identifiable, Decodable {}

struct Listing {
    let after : String
    var posts = [Post]() //children
}

struct Post: Model {
    let id: String
    let name: String
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
    let text : String
    let likes : Bool?
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
        case id, title, author, url, media, domain, name, likes
        case subreddit = "subreddit_name_prefixed", video = "is_video", comments = "num_comments", upvote = "ups", creationTime = "created_utc", text = "selftext"
        case data
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        id = try dataContainer.decode(String.self, forKey: .id)
        name = try dataContainer.decode(String.self, forKey: .name)
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
        text = try dataContainer.decode(String.self, forKey: .text)
        likes = try dataContainer.decode(Bool?.self, forKey: .likes)
    }
}

extension Listing: Decodable {
    enum CodingKeys: String, CodingKey {
        case posts = "children"
        case after
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let data = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        posts = try data.decode([Post].self, forKey: .posts)
        after = try data.decode(String.self, forKey: .after)
        

    }
}


struct Account : Decodable {
    let comment_karma : Int
    let has_mail : Bool?
    let has_mod_mail : Bool?
    let has_verified_email : Bool?
    let id : String
    let inbox_count : Int
    let is_friend : Bool?
    let is_gold : Bool
    let is_mod : Bool
    let link_karma : Int
    let modhash : String?
    let name : String
    let over_18: Bool
}
