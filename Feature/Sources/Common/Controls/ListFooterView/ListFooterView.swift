import SwiftUI

public struct ListFooterView: View {
    var link: AttributedString
    var color: Color
    
    public init(link: AttributedString, color: Color) {
        self.link = link
        self.color = color
    }
    
    public var body: some View {
        VStack(spacing: 4.0) {
            DotsActivityView(color: color)
            HStack {
                Spacer()
                Text(link)
                    .fontWeight(.medium)
                Spacer()
            }
        }
    }
}

public struct ListFooterView_Previews: PreviewProvider {
    public static var previews: some View {
        ZStack {
            Color.gray
            ListFooterView(
                link: AttributedString("AttributedString"),
                color: .red
            )
        }
        .frame(height: 48.0)
    }
}
