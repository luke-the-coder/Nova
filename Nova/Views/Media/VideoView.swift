import AVKit
import SwiftUI

struct VideoView: View{
    @State var player = AVPlayer()
    var videoURL: String
    
    var body : some View{
        VideoPlayer(player: player).frame(height: 400).compositingGroup()
            .onAppear() {
                player = AVPlayer(url: URL(string: videoURL)!)
                player.play()
            }
            .onDisappear() {
                player.pause()
            }
    }
}
