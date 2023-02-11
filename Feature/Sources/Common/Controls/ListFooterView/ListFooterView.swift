import SwiftUI

public struct ListFooterView: View {
    var link: AttributedString
    var color: Color
    @State var firstScale = CGFloat.zero
    @State var secondScalse = CGFloat.zero
    @State var thriedScale = CGFloat.zero
    
    public init(link: AttributedString, color: Color) {
        self.link = link
        self.color = color
    }
    
    public var body: some View {
        VStack {
            HStack {
                Group {
                    Circle()
                        .fill(color)
                        .scaleEffect(firstScale)
                    Circle()
                        .fill(color)
                        .scaleEffect(secondScalse)
                    Circle()
                        .fill(color)
                        .scaleEffect(thriedScale)
                }
                .frame(width: 4.0)
            }
            HStack {
                Spacer()
                Text(link)
                    .fontWeight(.medium)
                Spacer()
            }
        }
        .onAppear {
            withAnimation(Animation.easeIn.repeatForever()) {
                self.firstScale = 1.0
            }
            withAnimation(Animation.easeIn.repeatForever().delay(0.3)) {
                self.secondScalse = 1.0
            }
            withAnimation(Animation.easeIn.repeatForever()) {
                self.thriedScale = 1.0
            }
        }
    }
}

public struct ListFooterView_Previews: PreviewProvider {
    public static var previews: some View {
        ListFooterView(link: AttributedString("AttributedString"),
                       color: .red)
    }
}
