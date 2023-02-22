import Foundation

public struct MUrl: Codable, Equatable {
    public var type: String?
    public var ur: String?
}

public struct MImage: Codable, Equatable {
    public var path: String?
    public var `extension`: String?
    
    public enum Size {
        case standardMedium
        case portraitUncanny
        
        var string: String {
            switch self {
            case.standardMedium:
                return "/standard_medium"
            case .portraitUncanny:
                return "/portrait_uncanny"
            }
        }
    }
    
    public static func parseThumbnail(_ image: MImage?, size: MImage.Size) -> URL {
        if var path = image?.path {
            path = path.replacingOccurrences(of: "http:", with: "https:")
            path += size.string
            if let ext = image?.extension {
                path += ("." + ext)
            } else {
                path += ".jpg"
            }
            if let url = URL(string: path) {
                return url
            } else {
                return URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available\(size.string).jpg")!
            }
        } else {
            return URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available\(size.string).jpg")!
        }
    }
}

public struct ComicList: Codable, Equatable {
    public var available: Int?
    public var returned: Int?
    public var collectionURI: String?
    public var items: [Self.ComicSummary]?
    
    public struct ComicSummary: Codable, Equatable {
        public var resourceURI: String?
        public var name: String?
    }
}

public struct StoryList: Codable, Equatable {
    public var available: Int?
    public var returned: Int?
    public var collectionURI: String?
    public var items: [Self.StorySummary]?
    
    public struct StorySummary: Codable, Equatable {
        public var resourceURI: String?
        public var name: String?
        public var type: String?
    }
}

public struct EventList: Codable, Equatable {
    public var available: Int?
    public var returned: Int?
    public var collectionURI: String?
    public var items: [Self.EventSummary]?
    
    public struct EventSummary: Codable, Equatable {
        public var resourceURI: String?
        public var name: String?
    }
}

public struct CharacterList: Codable, Equatable {
    public var available: Int?
    public var returned: Int?
    public var collectionURI: String?
    public var items: [Self.CharacterSummary]?
    
    public struct CharacterSummary: Codable, Equatable {
        public var resourceURI: String?
        public var name: String?
        public var role: String?
    }
}

public struct CreatorList: Codable, Equatable {
    public var available: Int?
    public var returned: Int?
    public var collectionURI: String?
    public var items: [Self.CreatorSummary]?
    
    public struct CreatorSummary: Codable, Equatable {
        public var resourceURI: String?
        public var name: String?
        public var role: String?
    }
}

public struct SeriesList: Codable, Equatable {
    public var available: Int?
    public var returned: Int?
    public var collectionURI: String?
    public var items: [Self.SeriesSummary]?
    
    public struct SeriesSummary: Codable, Equatable {
        public var resourceURI: String?
        public var name: String?
    }
}
