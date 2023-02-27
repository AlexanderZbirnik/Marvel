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
        public var description: String?
        public var modified: String?
        public var isbn: String?
        public var upc: String?
        public var diamondCode: String?
        public var ean: String?
        public var issn: String?
        public var format: String?
        public var pageCount: String?
        public var  textObjects: [TextObject] = []
        public var resourceURI: String?
        public var urls: [MUrl]?
        public var series: SeriesList?
        public var variants: [ComicList.ComicSummary]?
        public var collections: [ComicList.ComicSummary]?
        public var collectedIssues: [ComicList.ComicSummary]?
        public var  dates: [ComicDate]?
        public var  prices: [ComicPrice]?
        public var thumbnail: MImage?
        public var images: [MImage]?
        public var creators: CreatorList?
        public var characters: CharacterList?
        public var stories: StoryList?
        public var events: EventList?

        public typealias Id = Tagged<Comics, Int>
    }
}
