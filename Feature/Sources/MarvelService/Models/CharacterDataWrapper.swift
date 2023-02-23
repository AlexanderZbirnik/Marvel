import Foundation
import Tagged

public typealias Character = CharacterDataWrapper.CharacterDataContainer.Character

public struct CharacterDataWrapper: Codable {
    public var code: Int?
    public var status: String?
    public var copyright: String?
    public var attributionText: String?
    public var attributionHTML: String?
    public var etag: String?
    public var data: CharacterDataWrapper.CharacterDataContainer?
}

extension CharacterDataWrapper {
    public struct CharacterDataContainer: Codable {
        public var offset: Int?
        public var limit: Int?
        public var total: Int?
        public var count: Int?
        public var results: [CharacterDataContainer.Character]?
    }
}

extension CharacterDataWrapper.CharacterDataContainer {
    public struct Character: Codable, Equatable, Identifiable {
        public var id: Id
        public var name: String?
        public var description: String?
        public var modified: String?
        public var resourceURI: String?
        public var urls: [MUrl] = []
        public var thumbnail: MImage?
        public var comics: ComicList?
        public var stories: StoryList?
        public var events: EventList?
        public var series: SeriesList?
        
        public typealias Id = Tagged<Character, Int>
    }
}

// MARK: - Mocks

extension CharacterDataWrapper.CharacterDataContainer.Character {
    public static let mock: Self = {
        var character = Self(id: .init(1009368))
        character.name = "Iron Man"
        character.thumbnail?.path = "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55"
        character.thumbnail?.extension = "jpg"
        character.description = "Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man."
        character.comics = .mock
        character.series = .mock
        character.urls = [
            MUrl(type: "detail",
                 url: "http://marvel.com/comics/characters/1009368/iron_man?utm_campaign=apiRef&utm_source=a0e20b6e3044ac0bdea022dabdeddf1a"),
            MUrl(type: "wiki",
                 url: "http://marvel.com/universe/Iron_Man_(Anthony_Stark)?utm_campaign=apiRef&utm_source=a0e20b6e3044ac0bdea022dabdeddf1a"),
            MUrl(type: "comiclink",
                 url: "http://marvel.com/comics/characters/1009368/iron_man?utm_campaign=apiRef&utm_source=a0e20b6e3044ac0bdea022dabdeddf1a")
        ]
        
        return character
    }()
}

extension SeriesList {
    public static let mock: Self = {
        var series = SeriesList()
        series.available = 3
        series.returned = 3
        series.collectionURI = "http://gateway.marvel.com/v1/public/characters/1009368/series"
        series.items = [
            SeriesList.SeriesSummary(
                resourceURI: "http://gateway.marvel.com/v1/public/series/16450",
                name: "A+X (2012 - 2014)"
            ),
            SeriesList.SeriesSummary(
                resourceURI: "http://gateway.marvel.com/v1/public/series/6079",
                name: "Adam: Legend of the Blue Marvel (2008)"
            ),
            SeriesList.SeriesSummary(
                resourceURI: "http://gateway.marvel.com/v1/public/series/27392",
                name: "Aero (2019 - 2020)"
            )
        ]
        return series
    }()
}

