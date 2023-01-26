import SwiftUI

public struct Palette {
    public static let black = Color(red: 0.0, green: 0.0, blue: 0.0)
    public static let white = Color(red: 1.0, green: 1.0, blue: 1.0)
    public static let red = Color(red: 0.85, green: 0.20, blue: 0.16)
    public static let lightGray = Color(red: 0.11, green: 0.11, blue: 0.11)
    public static let darkGray = Color(red: 0.08, green: 0.08, blue: 0.08)
    public static let gray = Color(red: 0.32, green: 0.32, blue: 0.32)
}

struct PaletteView: View {
    var body: some View {
        ZStack {
            Color.gray
            List {
                color(Palette.black, title: "black - #000000", titleColor: .white)
                color(Palette.white, title: "white - #FFFFFF", titleColor: .black)
                color(Palette.red, title: "red - #D93428", titleColor: .white)
                color(Palette.lightGray, title: "lightGray - #1D1D1D", titleColor: .white)
                color(Palette.darkGray, title: "darkGray - #151515", titleColor: .white)
                color(Palette.gray, title: "gray - #525252", titleColor: .white)
            }
            
        }
    }
    
    @ViewBuilder
    func color(_ color: Color, title: String, titleColor: Color) -> some View {
        ZStack {
            color
                .frame(height: 64.0)
                .border(Color.secondary, width: 2.0)
            Text(title)
                .font(.title)
                .foregroundColor(titleColor)
                .fontWeight(.semibold)
        }
        .listRowSeparator(.hidden)
    }
}

struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteView()
    }
}
