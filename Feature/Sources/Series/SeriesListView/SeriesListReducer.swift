import Foundation
import ComposableArchitecture
import MarvelService
import Common
import Tagged

public struct SeriesListReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id: Tagged<Self, String> = .init("series_list_id")
        public var apiParameters: [String: String] = [:]
        var firstOnAppear = true
        var seriesItems: IdentifiedArrayOf<SeriesItemReducer.State> = []
        var copyright = AttributedString()
        var showFooter = false
        
        public init() {}
    }
    
    public init() {}
    
    public enum Action: Equatable {
        case onAppear
        case loadSeries
        case seriesLoaded(SeriesList)
        case seriesItem(id: Series.Id, action: SeriesItemReducer.Action)
    }
    
    @Dependency(\.seriesClient) var seriesClient
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return onAppearAction(&state)
            case .loadSeries:
                return loadSeriesAction(&state)
            case let .seriesLoaded(seriesList):
                seriesLoadedAction(&state, seriesList: seriesList)
            case let .seriesItem(id, seriesItemAction):
                return seriesItemActions(&state, id: id, action: seriesItemAction)
            }
            return .none
        }
        .forEach(\.seriesItems, action: /Action.seriesItem(id:action:)) {
            SeriesItemReducer()
        }
    }
}

// MARK: - Actions

extension SeriesListReducer {
    func onAppearAction(_ state: inout State) -> EffectTask<Action> {
        if state.firstOnAppear {
            state.firstOnAppear = false
            return .task { .loadSeries }
        }
        return .none
    }
    
    func loadSeriesAction(_ state: inout State) -> EffectTask<Action> {
        state.apiParameters["limit"] = "20"
        state.apiParameters["offset"] = "\(state.seriesItems.count)"
        return .task { [parameters = state.apiParameters] in
            .seriesLoaded(try await seriesClient.seriesList(parameters))
        }
    }
    
    func seriesLoadedAction(_ state: inout State, seriesList: SeriesList) {
        if let data = seriesList.attributionHTML.data(using: .unicode),
           let attributedString =
            try? NSAttributedString(data: data,
                                    options: [.documentType: NSAttributedString.DocumentType.html],
                                    documentAttributes: nil) {
            state.copyright = AttributedString(attributedString)
            state.copyright.foregroundColor = Palette.red
            state.copyright.font = .callout
        }
        var seriesItems: IdentifiedArrayOf<SeriesItemReducer.State> = []
        for series in seriesList.series {
            seriesItems.append(SeriesItemReducer.State(series))
        }
        state.seriesItems += seriesItems
        state.showFooter = !state.seriesItems.isEmpty
    }
    
    func seriesItemActions(_ state: inout State, id: Series.Id, action: SeriesItemReducer.Action) -> EffectTask<Action> {
        if action == .onAppear {
            Haptic.feedback(.soft)
            if id == (state.seriesItems.last?.id ?? .init(0)) {
                return .task { .loadSeries }
            }
        }
        return .none
    }
}
