import Foundation
import ComposableArchitecture
import MarvelService
import Common

public struct CharacterItemReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id: Character.Id
        var name = ""
        var imageUrl: URL
        
        public init(_ character: Character) {
            self.id = character.id
            self.name = character.name ?? ""
            self.imageUrl = Self.parseThumbnail(character.thumbnail)
        }
        
        static func parseThumbnail(_ image: MImage?) -> URL {
            if var path = image?.path {
                path = path.replacingOccurrences(of: "http:", with: "https:")
                path += "/standard_medium"
                if let ext = image?.extension {
                    path += ("." + ext)
                } else {
                    path += ".jpg"
                }
                if let url = URL(string: path) {
                    return url
                } else {
                    return URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/standard_medium.jpg")!
                }
            } else {
                return URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/standard_medium.jpg")!
            }
        }
    }
    
    public init() {}
    
    public enum Action: Equatable {
        case onAppear
    }
    
    public var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
