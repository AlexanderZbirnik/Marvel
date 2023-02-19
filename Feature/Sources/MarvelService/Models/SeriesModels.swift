import Foundation
import UIKit

public struct SeriesList: Equatable {
    public var attributionHTML = ""
    public var series: [Series] = []
    
    public init() {
        self.attributionHTML =
        "<a href=\"http://marvel.com\">Data provided by Marvel. © 2023 MARVEL</a>"
    }
}

public struct SeriesCharactersList: Equatable, Identifiable {
    public var name = "Characters"
    public var url = ""
    public var items: [Self.Item] = []
    public var id: String {
        self.url
    }
    public var list: String {
        let names = self.items.map {
            $0.name
        }
        return names.joined(separator: ", ")
    }
    
    public init(_ characters: CharacterList) {
        self.url = characters.collectionURI ?? ""
        self.items = characters.items?.map({
            Item($0)
        }) ?? []
    }
    
    public struct Item: Equatable, Identifiable {
        public var name = ""
        public var url = ""
        
        public var id: String {
            self.url
        }
        
        public init(_ item: CharacterList.CharacterSummary) {
            self.name = item.name ?? ""
            self.url = item.resourceURI ?? ""
        }
    }
}
