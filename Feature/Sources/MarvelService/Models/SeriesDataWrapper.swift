import Foundation
import Tagged

public typealias Series = SeriesDataWrapper.SeriesDataContainer.Series

public struct SeriesList: Equatable {
    public var attributionHTML = ""
    public var series: [Series] = []
    
    public init() {
        self.attributionHTML =
        "<a href=\"http://marvel.com\">Data provided by Marvel. © 2023 MARVEL</a>"
    }
}

public struct SeriesDataWrapper: Codable {
    public var code: Int?
    public var status: String?
    public var copyright: String?
    public var attributionText: String?
    public var attributionHTML: String?
    public var etag: String?
    public var data: SeriesDataWrapper.SeriesDataContainer?
}

extension SeriesDataWrapper {
    public struct SeriesDataContainer: Codable {
        public var offset: Int?
        public var limit: Int?
        public var total: Int?
        public var count: Int?
        public var results: [SeriesDataContainer.Series]?
    }
}

extension SeriesDataWrapper.SeriesDataContainer {
    public struct Series: Codable, Equatable, Identifiable {
        public var id: Id
        public var title: String?
        public var description: String?
        public var resourceURI: String?
        public var urls: [MUrl] = []
        public var startYear: Int?
        public var endYear: Int?
        public var rating: String?
        public var modified: String?
        public var thumbnail: MImage?
        public var comics: ComicList?
        public var stories: StoryList?
        public var events: EventList?
        public var characters: CharacterList?
        public var creators: CreatorList?
        public var next: SeriesSummary?
        public var previous: SeriesSummary?
        
        public typealias Id = Tagged<Series, Int>
    }
}

public struct MUrl: Codable, Equatable {
    public var type: String?
    public var ur: String?
}

public struct MImage: Codable, Equatable {
    public var path: String?
    public var `extension`: String?
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

public struct SeriesSummary: Codable, Equatable {
    public var resourceURI: String?
    public var name: String?
}

// MARK: - Mocks

extension SeriesDataWrapper.SeriesDataContainer.Series {
    public static let mock: Self = {
        var series = Self(id: .init(0))
        series.title = "Any series title"
        series.startYear = 2020
        series.endYear = 2023
        series.thumbnail?.path = "http://i.annihil.us/u/prod/marvel/i/mg/4/b0/5d939e25a9787"
        series.thumbnail?.extension = "jpg"
        series.description = "Award-winning writer Neil Gaiman teams with artist Andy Kubert to re-imagine the Marvel Universe"
        return series
    }()
}
