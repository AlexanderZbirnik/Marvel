import SwiftUI

public struct LinksView: View {
    var links: LinksViewProtocol
    
    public init(links: LinksViewProtocol) {
        self.links = links
    }
    
    public var body: some View {
        VStack(spacing: 2.0) {
            SubtitleView(subtitle: links.name)
            HStack {
                ForEach(0..<links.links.count, id: \.self) { index in
                    Link(links.types[index],
                         destination: links.links[index])
                    .foregroundColor(Palette.red)
                    if index < links.links.count - 1 {
                        Circle()
                            .frame(width: 3.0)
                            .foregroundColor(Palette.red)
                            .offset(y: 2.0)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16.0)
            .padding(.vertical, 8.0)
        }
    }
}
