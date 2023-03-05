import Foundation

public struct PreviewComicsList: Equatable, Identifiable {
    public var id: String {
        self.url
    }
    public var name = "Comics"
    public var url = ""
    public var items: [Self.Item] = []
    
    public init(_ comics: ComicList) {
        self.url = comics.collectionURI ?? ""
        self.items = comics.items?.map({
            Item($0)
        }) ?? []
    }
    
    public struct Item: Equatable, Identifiable, Hashable {
        public var id: String {
            self.url
        }
        public var name = ""
        public var url = ""
        
        public init(_ item: ComicList.ComicSummary) {
            self.name = item.name ?? ""
            self.url = item.resourceURI ?? ""
        }
    }
}

public struct PreviewSeriesList: Equatable, Identifiable {
    public var id: String {
        self.url
    }
    public var name = "Series"
    public var url = ""
    public var items: [Self.Item] = []
    
    public init(_ series: SeriesList) {
        self.url = series.collectionURI ?? ""
        self.items = series.items?.map({
            Item($0)
        }) ?? []
    }
    
    public struct Item: Equatable, Identifiable, Hashable {
        public var id: String {
            self.url
        }
        public var name = ""
        public var url = ""
        
        public init(_ item: SeriesList.SeriesSummary) {
            self.name = item.name ?? ""
            self.url = item.resourceURI ?? ""
        }
    }
}

public struct PreviewLinksList: Equatable, Identifiable {
    public var id: String {
        self.name
    }
    public var name = "Links"
    public var types: [String] = []
    public var links: [URL] = []
    
    public init(_ urls: [MUrl]) {
        for url in urls {
            if let link = URL(string: url.url ?? "") {
                types.append(url.type ?? "")
                links.append(link)
            }
        }
    }
}

public struct PreviewCharactersList: Equatable, Identifiable {
    public var id: String {
        self.url
    }
    public var name = "Characters"
    public var url = ""
    public var items: [Self.Item] = []
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

public struct PreviewCreatorsList: Equatable, Identifiable {
    public var id: String {
        self.url
    }
    public var name = "Creators"
    public var url = ""
    public var items: [Self.Item] = []
    public var list: [Self.Role] = []
    
    public init(_ creators: CreatorList) {
        self.url = creators.collectionURI ?? ""
        self.items = creators.items?.map({
            Item($0)
        }) ?? []
        self.list = Role.parseItems(self.items)
    }
    
    public struct Role: Equatable, Hashable {
        public var title = ""
        public var names = ""
        
        public static func parseItems(_ items: [PreviewCreatorsList.Item]) -> [Role] {
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
        public var name = ""
        public var url = ""
        public var role = ""
        
        public init(_ item: CreatorList.CreatorSummary) {
            self.name = item.name ?? ""
            self.url = item.resourceURI ?? ""
            self.role = item.role ?? ""
        }
    }
}

public struct PreviewDate: Equatable, Identifiable {
    public var id: String {
        self.title
    }
    public var title = ""
    public var date = ""
    
    public init(type: String, date: String) {
        switch type {
        case "onsaleDate":
            self.title = "On sale: "
        case "focDate":
            self.title = "FOC: "
        case "unlimitedDate":
            self.title = "Unlimited: "
        case "digitalPurchaseDate":
            self.title = "Digital purchase: "
        default:
            self.title = ": " + type
        }
        self.date = date
    }
    
    public static func preview(_ comicDate: ComicDate) -> PreviewDate? {
        guard let type = comicDate.type, !type.isEmpty else {
            return nil
        }
        guard let dateString = comicDate.date, !dateString.isEmpty else {
            return nil
        }
        guard let date = try? Date(dateString, strategy: Date.ISO8601FormatStyle()) else {
            return nil
        }
        return .init(type: type, date: date.formatted(date: .numeric, time: .omitted))
    }
}

public struct PreviewPrice: Equatable, Identifiable {
    public var id: String {
        self.title
    }
    public var title = ""
    public var price = ""
    
    public init(type: String, price: String) {
        if type == "printPrice" {
            self.title = "Print price: "
        } else {
            self.title = type
        }
        self.price = price + "$"
    }
    
    public static func preview(_ comicPrice: ComicPrice) -> PreviewPrice? {
        guard let type = comicPrice.type, !type.isEmpty else {
            return nil
        }
        guard let price = comicPrice.price, price > .zero else {
            return nil
        }
        return .init(type: type, price: "\(price)")
    }
}
