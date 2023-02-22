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
        
        return character
    }()
}
