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
            self.imageUrl =
            MImage.parseThumbnail(character.thumbnail, size: .standardMedium)
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
