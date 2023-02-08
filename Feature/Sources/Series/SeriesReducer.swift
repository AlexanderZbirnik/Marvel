import ComposableArchitecture
import MarvelService
import Common

public struct SeriesReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id = "series_id"
        public var apiParameters: [String: String] = [:]
        
        public init() {}
    }
    
    public init() {}
    
    public enum Action: Equatable {
        case onAppear
        case loadSeries
    }
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            Log.action("SeriesReducer - onAppear")
            Task { [parameters = state.apiParameters] in
                var params = parameters
                params["limit"] = "1"
                guard let result = await MockMarvelService.series() else {
                    return
                }
                Log.action("SeriesReducer - result: \(result)")
            }
        case .loadSeries:
            Log.action("SeriesReducer - loadSeries")
        }
        return .none
    }
}
