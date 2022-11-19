import Kingfisher
import SwiftUI

struct ImagesView : View {
    var URL : String
    var body : some View{
        KFImage(Foundation.URL(string: URL)).placeholder {
            // Placeholder while downloading.
            Image(systemName: "arrow.2.circlepath.circle")
                .font(.largeTitle)
                .opacity(0.3)
        }.resizable().cancelOnDisappear(true).aspectRatio(contentMode: .fit)//.frame(width: 128, height: 128)
    }
}

