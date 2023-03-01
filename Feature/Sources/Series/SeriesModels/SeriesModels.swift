import Foundation
import MarvelService
import Common

public struct SeriesList: Equatable {
    public var attributionHTML = ""
    public var series: [Series] = []
    
    public init() {
        self.attributionHTML =
        "<a href=\"http://marvel.com\">Data provided by Marvel. © 2023 MARVEL</a>"
    }
}
