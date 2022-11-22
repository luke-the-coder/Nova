import SwiftUI

struct SinglePostView : View {
    var bodyText : String
    var body: some View {
        Section{
            Text(bodyText).lineLimit(...3)
            
        }.padding(4)
    }
}
