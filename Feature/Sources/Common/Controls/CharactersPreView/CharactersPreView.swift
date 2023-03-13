import SwiftUI

public struct CharactersPreView: View {
    var title: String
    var characters: String
    
    public init(title: String, characters: String) {
        self.title = title
        self.characters = characters
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            SubtitleView(subtitle: title)
            HStack {
                Text(characters)
                    .font(.headline)
                    .fontWeight(.regular)
                    .italic()
                    .foregroundColor(Palette.white)
                    .padding(.horizontal, 16.0)
                    .padding(.top, 4.0)
                Spacer()
            }
        }
    }
}

public struct CharactersPreView_Previews: PreviewProvider {
    public static var previews: some View {
        ZStack {
            Color.gray
            CharactersPreView(title: "Characters",
                              characters: "characterOne, characterTwo")
        }
    }
}
