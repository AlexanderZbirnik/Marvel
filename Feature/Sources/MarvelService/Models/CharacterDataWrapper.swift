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
