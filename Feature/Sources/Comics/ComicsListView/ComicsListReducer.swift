import Foundation
import ComposableArchitecture
import Common
import MarvelService

public struct ComicsListReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id = "comics_list_id"
        public var apiParameters: [String: String] = [:]
        var firstOnAppear = true
        var copyright = AttributedString()
        var showFooter = false
        
        public init() {}
    }
    
    public init() {}
    
    public enum Action: Equatable {
        case onAppear
    }
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            }
        }
    }
}

// MARK: - Actions
