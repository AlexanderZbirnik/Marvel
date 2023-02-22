import ComposableArchitecture
import Common
import MarvelService

public struct CharactersReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id = "series_id"
        public var apiParameters: [String: String] = [:]
        
        public init() {}
    }
    
    public init() {}
    
    public enum Action: Equatable {
        case onAppear
    }
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            Log.action("\(Self.self) - onAppear")
        }
        return .none
    }
}
