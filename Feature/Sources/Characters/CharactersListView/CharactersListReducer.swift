import Foundation
import ComposableArchitecture
import Common
import MarvelService

public struct CharactersListReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id = "characters_list_id"
        public var apiParameters: [String: String] = [:]
        var firstOnAppear = true
        var charactersItems: IdentifiedArrayOf<CharacterItemReducer.State> = []
        var copyright = AttributedString()
        var showFooter = false
        
        public init() {}
    }
    
    public init() {}
    
    public enum Action: Equatable {
        case onAppear
        case loadCharacters
        case charactersLoaded(CharactersList)
        case characterItem(id: Character.Id, action: CharacterItemReducer.Action)
    }
    
    @Dependency(\.charactersClient) var charactersClient
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return onAppearAction(&state)
            case .loadCharacters:
                return loadCharactersAction(&state)
            case let .charactersLoaded(charactersList):
                charactersLoadedAction(&state, charactersList: charactersList)
            case let .characterItem(id, characterItemAction):
                return characterItemActions(&state, id: id, action: characterItemAction)
            }
            return .none
        }
        .forEach(\.charactersItems, action: /Action.characterItem(id:action:)) {
            CharacterItemReducer()
        }
    }
}

// MARK: - Actions

extension CharactersListReducer {
    func onAppearAction(_ state: inout State) -> EffectTask<Action> {
        if state.firstOnAppear {
            state.firstOnAppear = false
            return .task { .loadCharacters }
        }
        return .none
    }
    
    func loadCharactersAction(_ state: inout State) -> EffectTask<Action> {
        state.apiParameters["limit"] = "20"
        state.apiParameters["offset"] = "\(state.charactersItems.count)"
        return .task { [parameters = state.apiParameters] in
            .charactersLoaded(try await charactersClient.charactersList(parameters))
        }
    }
    
    func charactersLoadedAction(_ state: inout State, charactersList: CharactersList) {
        if let data = charactersList.attributionHTML.data(using: .unicode),
           let attributedString =
            try? NSAttributedString(data: data,
                                    options: [.documentType: NSAttributedString.DocumentType.html],
                                    documentAttributes: nil) {
            state.copyright = AttributedString(attributedString)
            state.copyright.foregroundColor = Palette.red
            state.copyright.font = .callout
        }
        var charactersItems: IdentifiedArrayOf<CharacterItemReducer.State> = []
        for character in charactersList.characters {
            charactersItems.append(CharacterItemReducer.State(character))
        }
        state.charactersItems += charactersItems
        state.showFooter = !state.charactersItems.isEmpty
    }
    
    func characterItemActions(_ state: inout State, id: Character.Id, action: CharacterItemReducer.Action) -> EffectTask<Action> {
        if action == .onAppear {
            Haptic.feedback(.soft)
            if id == (state.charactersItems.last?.id ?? .init(0)) {
                return .task { .loadCharacters }
            }
        }
        return .none
    }
}
