import SwiftUI
import Common

struct LaunchView: View {
    @State private var progress = 0.0
    @State private var opacity = 1.0
    
    var body: some View {
        ZStack {
            Palette.red
                .ignoresSafeArea()
            Group {
                StrokeShape(edge: .top)
                    .trim(from: 0.0, to: progress)
                    .stroke(Palette.white, lineWidth: 2.0)
                StrokeShape(edge: .left)
                    .trim(from: 0.0, to: progress)
                    .stroke(Palette.white, lineWidth: 2.0)
                StrokeShape(edge: .bottom)
                    .trim(from: 0.0, to: progress)
                    .stroke(Palette.white, lineWidth: 2.0)
                StrokeShape(edge: .right)
                    .trim(from: 0.0, to: progress)
                    .stroke(Palette.white, lineWidth: 2.0)
            }
            .frame(width: 272.0, height: 110.0)
            Image("logo")
                .resizable()
                .frame(width: 256.0, height: 94.0)
        }
        .onAppear {
            withAnimation(.easeIn(duration: 1.1)) {
                self.progress = 1.0
            }
            Task {
                try await Task.sleep(nanoseconds: 1_100_000_000)
                withAnimation(.easeIn(duration: 0.3)) {
                    self.opacity = .zero
                }
            }
        }
        .opacity(opacity)
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}

struct StrokeShape: Shape {
    private var edge = Self.Edge.top
    
    init(edge: StrokeShape.Edge) {
        self.edge = edge
    }
    
    enum Edge {
        case left, top, right, bottom
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            switch self.edge {
            case .left:
                path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            case .top:
                path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            case .right:
                path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            case .bottom:
                path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            }
        }
    }
}
