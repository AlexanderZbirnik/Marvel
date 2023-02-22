import Foundation
import MarvelService
import Common

public struct CharactersList: Equatable {
    public var attributionHTML = ""
    public var characters: [Character] = []
    
    public init() {
        self.attributionHTML =
        "<a href=\"http://marvel.com\">Data provided by Marvel. © 2023 MARVEL</a>"
    }
}
