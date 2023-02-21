import Foundation
import Tagged

public typealias Series = SeriesDataWrapper.SeriesDataContainer.Series

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
        var series = Self(id: .init(30148))
        series.title = "Iron Man (2020 - Present)"
        series.startYear = 2020
        series.endYear = 2099
        series.thumbnail?.path = "http://i.annihil.us/u/prod/marvel/i/mg/c/c0/5f60c70ccd7f9"
        series.thumbnail?.extension = "jpg"
        series.description = "BIG IRON! Tony Stark is looking to restart his engine. He decides he’s going back to basics, putting away his high-tech toys and high-profile image so he can get his hands dirty again. It’s time to dig into the guts of real machines, put on some old-fashioned metal and fly. But can he really lay that Stark-sized ego down? Life isn’t that simple, something that old friends and frustrating foes are quick to point out. If you strip down a billionaire to his bolts, does he run solid or just overheat? Tony’s going to find out once a threat to the entire universe rears its head from the past. As he suits up again, Tony remains sure of one thing: he’s still IRON MAN down to his flesh and blood core. "
        series.characters = .mock
        series.creators = .mock
        series.comics = .mock
        
        return series
    }()
}

extension CharacterList {
    public static let mock: Self = {
        var characters = CharacterList()
        characters.available = 2
        characters.returned = 2
        characters.collectionURI = "http://gateway.marvel.com/v1/public/series/30148/characters"
        characters.items = [
            CharacterList.CharacterSummary(resourceURI: "http://gateway.marvel.com/v1/public/characters/1011286", name: "Cobalt Man"),
            CharacterList.CharacterSummary(resourceURI: "http://gateway.marvel.com/v1/public/characters/1009368", name: "Iron Man")
        ]
        return characters
    }()
}

extension CreatorList {
    public static let mock: Self = {
        var creators = CreatorList()
        creators.available = 2
        creators.returned = 2
        creators.collectionURI = "http://gateway.marvel.com/v1/public/series/16593/creators"
        creators.items = [
            CreatorList.CreatorSummary(
                resourceURI: "http://gateway.marvel.com/v1/public/creators/8571",
                name: "Guru-eFX",
                role: "colorist"
            ),
            CreatorList.CreatorSummary(
                resourceURI: "http://gateway.marvel.com/v1/public/creators/9018",
                name: "Mahmud Asrar",
                role: "artist"
            ),
            CreatorList.CreatorSummary(
                resourceURI: "http://gateway.marvel.com/v1/public/creators/8901",
                name: "Kieron Gillen",
                role: "writer"
            )
        ]
        return creators
    }()
}

extension ComicList {
    public static let mock: Self = {
        var comics = ComicList()
        comics.available = 3
        comics.returned = 3
        comics.collectionURI = "http://gateway.marvel.com/v1/public/series/16593/comics"
        comics.items = [
            ComicList.ComicSummary(
                resourceURI: "http://gateway.marvel.com/v1/public/comics/43944",
                name: "Iron Man (2012) #1"
            ),
            ComicList.ComicSummary(
                resourceURI: "http://gateway.marvel.com/v1/public/comics/47357",
                name: "Iron Man (2012) #1 (2nd Printing)"
            ),
            ComicList.ComicSummary(
                resourceURI: "http://gateway.marvel.com/v1/public/comics/43952",
                name: "Iron Man (2012) #2"
            )
        ]
        return comics
    }()
}
