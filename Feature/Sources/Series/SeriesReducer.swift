import ComposableArchitecture

public struct SeriesReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id = "series_id"
        
        public init() {}
    }
    
    public init() {}
    
    public enum Action: Equatable {}
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {}
}
