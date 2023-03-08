import SwiftUI

public struct DetailView: View {
    var detail: String
    
    public init(detail: String) {
        self.detail = detail
    }
    
    public var body: some View {
        HStack {
            Text(detail)
                .font(.body)
                .foregroundColor(Palette.white)
                .padding(.horizontal, 16.0)
                .padding(.top, 24.0)
            Spacer()
        }
    }
}

public struct DetailView_Previews: PreviewProvider {
    public static var previews: some View {
        ZStack {
            Color.gray
            DetailView(detail: "Any detsail text...")
        }
    }
}
