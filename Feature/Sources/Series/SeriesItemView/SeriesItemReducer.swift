import ComposableArchitecture
import MarvelService
import Common

public struct SeriesItemReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id = ""
        var title = ""
        var series: Series?
        
        public init() {}
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
