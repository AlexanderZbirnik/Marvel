import SwiftUI

public extension Image {
    static var bigRectPlaceholder: Image {
        Image("big_rectangle_placeholder", bundle: .module)
    }
    static var smallRectPlaceholder: Image {
        Image("small_rectangle_placeholder", bundle: .module)
    }
    static var squarePlaceholder: Image {
        Image("square_placeholder", bundle: .module)
    }
}
