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
        
        init() {
            Log.action("AppReducer - init")
        }
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
                Log.action("AppReducer - onAppear")
                return .task {
                    .series(.loadSeries)
                }
            case .series:
                Log.action("AppReducer - series")
            case .characters:
                Log.action("AppReducer - series")
            case .tabSelected:
                Log.action("AppReducer - tabSelected")
                Haptic.feedback(.selectionChanged)
            }
            return .none
        }
    }
}

