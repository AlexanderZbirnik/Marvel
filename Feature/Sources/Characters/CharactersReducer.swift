import Foundation
import ComposableArchitecture
import Common
import MarvelService

public struct CharactersReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id = "series_id"
        public var apiParameters: [String: String] = [:]
        var firstOnAppear = true
        var copyright = AttributedString()
        var showFooter = false
        
        public init() {}
    }
    
    public init() {}
    
    public enum Action: Equatable {
        case onAppear
        case loadCharacters
        case charactersLoaded(CharactersList)
    }
    
    @Dependency(\.charactersClient) var charactersClient
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            return onAppearAction(&state)
        case .loadCharacters:
            return loadCharactersAction(&state)
        case let .charactersLoaded(charactersList):
            Log.action("\(Self.self) - charactersLoaded: \(charactersList.characters.count)")
        }
        return .none
    }
}

// MARK: - Actions

extension CharactersReducer {
    func onAppearAction(_ state: inout State) -> EffectTask<Action> {
        Log.action("\(Self.self) - onAppear")
        if state.firstOnAppear {
            state.firstOnAppear = false
            return .task { .loadCharacters }
        }
        return .none
    }
    
    func loadCharactersAction(_ state: inout State) -> EffectTask<Action> {
        Log.action("\(Self.self) - loadCharacters")
        state.apiParameters["limit"] = "20"
        // TODO: - Replace offset on real
        state.apiParameters["offset"] = "\(0)"
        return .task { [parameters = state.apiParameters] in
            .charactersLoaded(try await charactersClient.charactersList(parameters))
        }
    }
}
