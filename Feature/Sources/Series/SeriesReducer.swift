import ComposableArchitecture
import MarvelService
import Common

public struct SeriesReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id = "series_id"
        public var apiParameters: [String: String] = [:]
        var firstOnAppear = true
        var series: [Series] = []
        
        public init() {}
    }
    
    public init() {}
    
    public enum Action: Equatable {
        case onAppear
        case loadSeries
        case seriesLoaded([Series])
    }
    
    @Dependency(\.seriesClient) var seriesClient
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
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
        case let .seriesLoaded(series):
            Log.action("\(Self.self) - seriesLoaded: \(series)")
            state.series = series
        }
        return .none
    }
}
