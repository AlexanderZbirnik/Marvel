import ComposableArchitecture
import Common
import SwiftUI
import Series
import Characters

struct AppReducer: ReducerProtocol {
    struct State: Equatable, Identifiable {
        let id = "app_id"
        var tab: TabItem = .series
        var series = SeriesReducer.State()
        var characters = CharactersReducer.State()
    }
    
    enum TabItem: Int {
        case series
        case characters
    }
    
    enum Action: Equatable {
        case onAppear
        case series(SeriesReducer.Action)
        case characters(CharactersReducer.Action)
        case tabSelected(TabItem)
    }
        
    var body: some ReducerProtocolOf<Self> {
        Scope(state: \.series, action: /Action.series) {
            SeriesReducer()
        }
        Scope(state: \.characters, action: /Action.characters) {
            CharactersReducer()
        }
        Reduce { state, action in
            switch action {
            case .onAppear:
                Log.action("onAppear")
            case .series:
                Log.action("series")
            case .characters:
                Log.action("series")
            case .tabSelected:
                Log.action("tabSelected")
                Haptic.feedback(.selectionChanged)
            }
            return .none
        }
    }
}

