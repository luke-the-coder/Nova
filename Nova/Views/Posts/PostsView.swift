import Foundation
import SwiftUI

struct PostsView : View{
    let api = API()
    @State var upvote : Bool = false
    @State var downvote : Bool = false
    var post : Post
    var body : some View{
        VStack(alignment: .leading){
            Text(post.title).bold().accessibilityElement().accessibilityLabel(post.title)
            Text("u/" + post.author).italic().accessibilityElement().accessibilityLabel("The post author is " + post.author)
            
            if (URL(string: post.url)?.pathExtension == "jpg" || URL(string:post.url)?.pathExtension == "png") {
                ImagesView(URL: post.url)
            }
            else if (URL(string: post.url)?.pathExtension == "gif"){
                GIFView(URL: post.url).scaledToFit()
            }
            else if (post.video){
                VideoView(videoURL: (post.media?.reddit_video?.fallback_url)!)
            }
            else if (post.domain != "i.redd.it" || post.domain != "v.redd.it" || post.domain != "gfycat.com" || post.domain != "i.imgur.com"){
                if (!(post.domain.hasPrefix("self"))){
                    WebView(URL: post.url)
                }
                else {
                    SinglePostView(bodyText: post.text)
                }

            }
            Divider()
            HStack{
                Image(systemName: upvote ? "arrowtriangle.up.circle.fill" : "arrowtriangle.up.circle").font(.system(size: 20, weight: .thin)).accessibilityElement().accessibilityLabel("Upvote").onTapGesture {
                    upvote.toggle()
                    if (upvote){
                        api.postAPICall(for: post.name, for: String(1))
                    }else{
                        api.postAPICall(for: post.name, for: String(0))
                    }
                }
                
                Text(formatPoints(from: post.upvote)).accessibilityElement().accessibilityLabel("The total upvotes are " + String(post.upvote))
                Image(systemName: "arrowtriangle.down.circle.fill").font(.system(size: 20, weight: .thin)).accessibilityElement().accessibilityLabel("Downvote")
                
                Spacer()
                Text(postTime(from: post.creationTime))
                Text(post.subreddit).italic().accessibilityElement().accessibilityLabel("The subreddit is " + post.subreddit)
                
            }.padding(.top, 4).onAppear(perform: {checkUpvote(from: post)})
        }
    }
    
    func checkUpvote(from: Post) {
        print(from.likes)
        if(from.likes == true){
            upvote = true
            downvote = false
        }
        else if(from.likes == false){
            downvote = true
            upvote = false
        } else {
            upvote = false
            downvote = false
        }
    }

    func formatPoints(from: Int) -> String {

        let number = Double(from)
        let thousand = number / 1000
        let million = number / 1000000
        let billion = number / 1000000000
        
        if billion >= 1.0 {
            //return "\(round(billion))B"
            return "\(ceil(billion*10)/10.0)B"
        } else if million >= 1.0 {
            //return "\(round(million))M"
            return "\(ceil(million*10)/10.0)M"
        } else if thousand >= 1.0 {
            //return ("\(round(thousand))K")
            return "\(ceil(thousand*10)/10.0)K"
        } else {
            return "\(Int(number))"
        }
    }
    
    func postTime(from: Int) -> String{
        let currentTime = Date().timeIntervalSince1970
        let postCreationTime = TimeInterval(from)

        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.month, .day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.allowsFractionalUnits = false
        formatter.maximumUnitCount = 1
        formatter.zeroFormattingBehavior = .dropAll
        let formatted = formatter.string(from: currentTime - postCreationTime) ?? ""
        return "\(formatted)"
    }
}
