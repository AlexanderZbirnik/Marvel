import Foundation
import ComposableArchitecture
import MarvelService
import Common

public struct CharacterReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id: Character.Id
        var name = ""
        var detail = ""
        var imageUrl: URL
        
        public init(_ character: Character) {
            self.id = character.id
            self.name = character.name ?? ""
            self.detail = character.description ?? ""
            self.imageUrl =
            MImage.parseThumbnail(character.thumbnail, size: .standardFantastic)
        }
    }
    
    public init() {}
    
    public enum Action: Equatable {
        case onAppear
    }
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            return .none
        }
    }
}
