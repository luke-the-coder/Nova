import Foundation
import SwiftUI

struct PostsView : View{
    var post : Post
    var body : some View{
        VStack(alignment: .leading){
            Text(post.title).bold()
            Text("u/" + post.author).italic()
            
            if (URL(string: post.url)?.pathExtension == "jpg" || URL(string: post.url)?.pathExtension == "png") {
                ImagesView(URL: post.url)
            }
            else if (post.video){
                VideoView(videoURL: (post.media?.reddit_video?.fallback_url)!)
            }
            else if (post.domain != "i.redd.it" || post.domain != "v.redd.it" || post.domain != "gfycat.com" || post.domain != "i.imgur.com"){
                if (!(post.domain.hasPrefix("self"))){
                    WebView(URL: post.url)
                }
            }

        }
    }
}
