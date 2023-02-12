import SwiftUI

public struct DotsActivityView: View {
    var color: Color
    @State var firstScale: CGFloat = 0.01
    @State var secondScalse: CGFloat = 0.01
    @State var thriedScale: CGFloat = 0.01
    
    public init(color: Color) {
        self.color = color
    }
    
    public var body: some View {
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

public struct DotsActivityView_Previews: PreviewProvider {
    public static var previews: some View {
        DotsActivityView(color: .red)
    }
}
