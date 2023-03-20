import Foundation
import ComposableArchitecture
import MarvelService
import Common

public struct CharacterItemReducer: Reducer {
    public struct State: Equatable, Identifiable {
        public var id: Character.Id
        var name = ""
        var imageUrl: URL
        var character: CharacterReducer.State
        
        public init(_ character: Character) {
            self.id = character.id
            self.name = character.name ?? ""
            self.imageUrl =
            MImage.parseThumbnail(character.thumbnail, size: .standardMedium)
            self.character = CharacterReducer.State(character)
        }
    }
    
    public init() {}
    
    public enum Action: Equatable {
        case onAppear
        case character(CharacterReducer.Action)
    }
    
    public var body: some ReducerProtocolOf<Self> {
        Scope(state: \.character, action: /Action.character) {
            CharacterReducer()
        }
        Reduce { state, action in
            switch action {
            case .character:
                Haptic.feedback(.soft)
            default:
                break
            }
            return .none
        }
    }
}
