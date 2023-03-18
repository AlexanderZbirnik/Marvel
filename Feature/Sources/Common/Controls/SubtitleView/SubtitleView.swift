import SwiftUI

public struct SubtitleView: View {
    var subtitle: String
    
    public init(subtitle: String) {
        self.subtitle = subtitle
    }
    
    public var body: some View {
        HStack {
            Text(subtitle)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(Palette.gray)
                .padding(.horizontal, 16.0)
                .padding(.top, 4.0)
            Spacer()
        }
    }
}

public struct SubtitleView_Previews: PreviewProvider {
    public static var previews: some View {
        ZStack {
            Color.gray
            SubtitleView(subtitle: "Any subtitle")
        }
    }
}
