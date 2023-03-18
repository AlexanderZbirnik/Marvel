import Foundation

public protocol LinksViewProtocol {
    var name: String { get set }
    var types: [String] { get set }
    var links: [URL] { get set }
}
