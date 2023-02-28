import Foundation
import ComposableArchitecture
import Common
import MarvelService

public struct ComicsListReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id = "comics_list_id"
        public var apiParameters: [String: String] = [:]
        var firstOnAppear = true
        var comicsItems: IdentifiedArrayOf<ComicsItemReducer.State> = []
        var copyright = AttributedString()
        var showFooter = false
        
        public init() {}
    }
    
    public init() {}
    
    public enum Action: Equatable {
        case onAppear
        case loadComics
        case comicsLoaded(ComicsList)
        case comicsItem(id: Comics.Id, action: ComicsItemReducer.Action)
    }
    
    @Dependency(\.comicsClient) var comicsClient
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return onAppearAction(&state)
            case .loadComics:
                return loadComicsAction(&state)
            case let .comicsLoaded(comicsList):
                comicsLoadedAction(&state, comicsList: comicsList)
            case let .comicsItem(id, comicsItemAction):
                return comicsItemActions(&state, id: id, action: comicsItemAction)
            }
            return .none
        }
        .forEach(\.comicsItems, action: /Action.comicsItem(id:action:)) {
            ComicsItemReducer()
        }
    }
}

// MARK: - Actions

extension ComicsListReducer {
    func onAppearAction(_ state: inout State) -> EffectTask<Action> {
        if state.firstOnAppear {
            state.firstOnAppear = false
            return .task { .loadComics }
        }
        return .none
    }
    
    func loadComicsAction(_ state: inout State) -> EffectTask<Action> {
        state.apiParameters["limit"] = "20"
        state.apiParameters["offset"] = "\(state.comicsItems.count)"
        return .task { [parameters = state.apiParameters] in
            .comicsLoaded(try await comicsClient.comicsList(parameters))
        }
    }
    
    func comicsLoadedAction(_ state: inout State, comicsList: ComicsList) {
        if let data = comicsList.attributionHTML.data(using: .unicode),
           let attributedString =
            try? NSAttributedString(data: data,
                                    options: [.documentType: NSAttributedString.DocumentType.html],
                                    documentAttributes: nil) {
            state.copyright = AttributedString(attributedString)
            state.copyright.foregroundColor = Palette.red
            state.copyright.font = .callout
        }
        var comicsItems: IdentifiedArrayOf<ComicsItemReducer.State> = []
        for comics in comicsList.comics {
            comicsItems.append(ComicsItemReducer.State(comics))
        }
        state.comicsItems += comicsItems
        state.showFooter = !state.comicsItems.isEmpty
    }
    
    func comicsItemActions(_ state: inout State, id: Comics.Id, action: ComicsItemReducer.Action) -> EffectTask<Action> {
        if action == .onAppear {
            Haptic.feedback(.soft)
            if id == (state.comicsItems.last?.id ?? .init(0)) {
                return .task { .loadComics }
            }
        }
        return .none
    }
}
