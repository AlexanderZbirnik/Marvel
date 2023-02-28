import Foundation
import Tagged

public typealias Comics = ComicsDataWrapper.ComicDataContainer.Comics

public struct ComicsDataWrapper: Codable {
    public var code: Int?
    public var status: String?
    public var copyright: String?
    public var attributionText: String?
    public var attributionHTML: String?
    public var etag: String?
    public var data: ComicsDataWrapper.ComicDataContainer?
}

extension ComicsDataWrapper {
    public struct ComicDataContainer: Codable {
        public var offset: Int?
        public var limit: Int?
        public var total: Int?
        public var count: Int?
        public var results: [ComicDataContainer.Comics]?
    }
}

extension ComicsDataWrapper.ComicDataContainer {
    public struct Comics: Codable, Equatable, Identifiable {
        public var id: Id
        public var digitalId: Int?
        public var issueNumber: Double?
        public var variantDescription: String?
        public var title: String?
        public var description: String?
        public var modified: String?
        public var isbn: String?
        public var upc: String?
        public var diamondCode: String?
        public var ean: String?
        public var issn: String?
        public var format: String?
        public var pageCount: Int?
        public var textObjects: [TextObject] = []
        public var resourceURI: String?
        public var urls: [MUrl]?
        public var series: SeriesList?
        public var variants: [ComicList.ComicSummary]?
        public var collections: [ComicList.ComicSummary]?
        public var collectedIssues: [ComicList.ComicSummary]?
        public var dates: [ComicDate]?
        public var prices: [ComicPrice]?
        public var thumbnail: MImage?
        public var images: [MImage]?
        public var creators: CreatorList?
        public var characters: CharacterList?
        public var stories: StoryList?
        public var events: EventList?

        public typealias Id = Tagged<Comics, Int>
    }
}

// MARK: - Mocks

extension ComicsDataWrapper.ComicDataContainer.Comics {
    public static let mock: Self = {
        var comics = Self(id: .init(101532))
        comics.title = "Iron Man (2022) #4"
        comics.thumbnail?.path = "http://i.annihil.us/u/prod/marvel/i/mg/c/a0/63dd8945aa5af"
        comics.thumbnail?.extension = "jpg"
        comics.description = nil
        comics.series = .mock
        comics.urls = [
            MUrl(type: "detail",
                 url: "http://marvel.com/comics/characters/1009368/iron_man?utm_campaign=apiRef&utm_source=a0e20b6e3044ac0bdea022dabdeddf1a"),
            MUrl(type: "wiki",
                 url: "http://marvel.com/universe/Iron_Man_(Anthony_Stark)?utm_campaign=apiRef&utm_source=a0e20b6e3044ac0bdea022dabdeddf1a"),
            MUrl(type: "comiclink",
                 url: "http://marvel.com/comics/characters/1009368/iron_man?utm_campaign=apiRef&utm_source=a0e20b6e3044ac0bdea022dabdeddf1a")
        ]
        
        return comics
    }()
}
