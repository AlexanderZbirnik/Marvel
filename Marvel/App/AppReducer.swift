import ComposableArchitecture
import Common
import SwiftUI
import Series
import Characters
import Comics
import CryptoKit
import MarvelService
import Tagged

struct AppReducer: Reducer {
    struct State: Equatable, Identifiable {
        let id: Tagged<Self, String> = .init("app_id")
        var tab: TabItem = .comics
        var series = SeriesListReducer.State()
        var characters = CharactersListReducer.State()
        var comics = ComicsListReducer.State()
        var showLaunch = true
        
        init() {
            let apiParameters = marvelApiParameters()
            self.series.apiParameters = apiParameters
            self.characters.apiParameters = apiParameters
            self.comics.apiParameters = apiParameters
        }
    }
    
    enum TabItem: Int, Equatable {
        case series
        case characters
        case comics
    }
    
    enum Action: Equatable {
        case onAppear
        case onAppearLaunch
        case hideLaunch
        case series(SeriesListReducer.Action)
        case characters(CharactersListReducer.Action)
        case comics(ComicsListReducer.Action)
        case tabSelected(TabItem)
    }
    
    @Dependency(\.continuousClock) var clock
    
    var body: some ReducerOf<Self> {
        Scope(state: \.series, action: /Action.series) {
            SeriesListReducer()
        }
        Scope(state: \.characters, action: /Action.characters) {
            CharactersListReducer()
        }
        Scope(state: \.comics, action: /Action.comics) {
            ComicsListReducer()
        }
        Reduce { state, action in
            switch action {
            case .onAppear, .characters, .series, .comics:
                break
            case .onAppearLaunch:
                return .run { send in
                    try await self.clock.sleep(for: .seconds(1.2))
                    await send(.hideLaunch, animation: .linear)
                }
            case .hideLaunch:
                state.showLaunch = false
            case let .tabSelected(tab):
                Haptic.feedback(.selectionChanged)
                state.tab = tab
            }
            return .none
        }
    }
}

extension AppReducer.State {
    private func marvelApiParameters() -> [String: String] {
        guard let filePath = Bundle.main.path(forResource: "Marvel-Info", ofType: "plist") else {
            return [:]
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let publicKey = plist?.object(forKey: "public_key") as? String else {
            return [:]
        }
        guard let privateKey = plist?.object(forKey: "private_key") as? String else {
            return [:]
        }
        let ts = String(Int(Date().timeIntervalSince1970 * 1000.0))
        let totalString = ts + privateKey + publicKey
        guard let data = totalString.data(using: .utf8) else {
            return [:]
        }
        let hash = Insecure.MD5.hash(data: data).map {
            String(format: "%02hhx", $0)
        }.joined()
        return [
            MarvelService.ApiKey.ts: ts,
            MarvelService.ApiKey.apiKey: publicKey,
            MarvelService.ApiKey.hash: hash
        ]
    }
}
