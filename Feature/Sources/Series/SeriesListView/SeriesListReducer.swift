import ComposableArchitecture
import MarvelService
import Common

public struct SeriesListReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id = "series_id"
        public var apiParameters: [String: String] = [:]
        var firstOnAppear = true
        var seriesItems: IdentifiedArrayOf<SeriesItemReducer.State> = []
        
        public init() {}
    }
    
    public init() {}
    
    public enum Action: Equatable {
        case onAppear
        case loadSeries
        case seriesLoaded([Series])
        case seriesItem(id: Series.Id, action: SeriesItemReducer.Action)
    }
    
    @Dependency(\.seriesClient) var seriesClient
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                if state.firstOnAppear {
                    state.firstOnAppear = false
                    return .task { [parameters = state.apiParameters] in
                            .seriesLoaded(try await seriesClient.series(parameters))
                    }
                }
                return .none
            case .loadSeries:
                Log.action("\(Self.self) - onAppear")
            case let .seriesLoaded(seriesList):
                Log.action("\(Self.self) - seriesLoaded: \(seriesList)")
                var seriesItems: IdentifiedArrayOf<SeriesItemReducer.State> = []
                for series in seriesList {
                    seriesItems.append(SeriesItemReducer.State(series))
                }
                state.seriesItems = seriesItems
            case let .seriesItem(id, _):
                Log.action("\(Self.self) - seriesItem id: \(id)")
            }
            return .none
        }
        .forEach(\.seriesItems, action: /Action.seriesItem(id:action:)) {
            SeriesItemReducer()
        }
    }
}
