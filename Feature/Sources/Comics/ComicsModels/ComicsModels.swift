import Foundation
import MarvelService
import Common

public struct ComicsList: Equatable {
    public var attributionHTML = ""
    public var comics: [Comics] = []
    
    public init() {
        self.attributionHTML =
        "<a href=\"http://marvel.com\">Data provided by Marvel. © 2023 MARVEL</a>"
    }
}
