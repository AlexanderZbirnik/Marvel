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

public struct SeriesCharactersList: Equatable, Identifiable {
    public var id: String {
        self.url
    }
    var name = "Characters"
    var url = ""
    var items: [Self.Item] = []
    var list: String {
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
        public var id: String {
            self.url
        }
        var name = ""
        var url = ""
        
        public init(_ item: CharacterList.CharacterSummary) {
            self.name = item.name ?? ""
            self.url = item.resourceURI ?? ""
        }
    }
}

public struct SeriesCreatorsList: Equatable, Identifiable {
    public var id: String {
        self.url
    }
    var name = "Creators"
    var url = ""
    var items: [Self.Item] = []
    var list: [Self.Role] = []
    
    public init(_ characters: CreatorList) {
        self.url = characters.collectionURI ?? ""
        self.items = characters.items?.map({
            Item($0)
        }) ?? []
        self.list = Role.parseItems(self.items)
    }
    
    public struct Role: Equatable, Hashable {
        var title = ""
        var names = ""
        
        public static func parseItems(_ items: [SeriesCreatorsList.Item]) -> [Role] {
            var rolesDictionary: [String: [String]] = [:]
            var roles: [Role] = []
            for item in items {
                if rolesDictionary[item.role]?.isEmpty ?? true {
                    rolesDictionary[item.role] = []
                }
                rolesDictionary[item.role]?.append(item.name)
            }
            for key in rolesDictionary.keys {
                if let names = rolesDictionary[key], !names.isEmpty {
                    roles.append(Role(title: key.capitalized, names: names.joined(separator: ", ")))
                }
            }
            return roles
        }
    }
    
    public struct Item: Equatable, Identifiable {
        public var id: String {
            self.url
        }
        var name = ""
        var url = ""
        var role = ""
        
        public init(_ item: CreatorList.CreatorSummary) {
            self.name = item.name ?? ""
            self.url = item.resourceURI ?? ""
            self.role = item.role ?? ""
        }
    }
}
