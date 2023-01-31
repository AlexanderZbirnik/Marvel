import ComposableArchitecture
import Common

public struct SeriesReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id = "series_id"
        
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
        case .loadSeries:
            Log.action("SeriesReducer - loadSeries")
        }
        return .none
    }
}
