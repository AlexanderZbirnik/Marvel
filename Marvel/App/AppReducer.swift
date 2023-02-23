import ComposableArchitecture
import Common
import SwiftUI
import Series
import Characters
import MarvelService

struct AppReducer: ReducerProtocol {
    struct State: Equatable, Identifiable {
        let id = "app_id"
        var tab: TabItem = .characters
        var series: SeriesListReducer.State
        var characters: CharactersListReducer.State
        
        init(apiParameters: [String: String]) {
            self.series = SeriesListReducer.State(apiParameters: apiParameters)
            self.characters = CharactersListReducer.State(apiParameters: apiParameters)
        }
    }
    
    enum TabItem: Int {
        case series
        case characters
    }
    
    enum Action: Equatable {
        case onAppear
        case series(SeriesListReducer.Action)
        case characters(CharactersListReducer.Action)
        case tabSelected(TabItem)
    }
    
    var body: some ReducerProtocolOf<Self> {
        Scope(state: \.series, action: /Action.series) {
            SeriesListReducer()
        }
        Scope(state: \.characters, action: /Action.characters) {
            CharactersListReducer()
        }
        Reduce { state, action in
            switch action {
            case .onAppear:
                Log.action("AppReducer - onAppear")
            case .series:
                return .none
            case .characters:
                Log.action("AppReducer - characters")
            case let .tabSelected(tab):
                Haptic.feedback(.selectionChanged)
                state.tab = tab
            }
            return .none
        }
    }
}
