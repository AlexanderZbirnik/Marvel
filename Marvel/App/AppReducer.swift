import ComposableArchitecture
import Common
import SwiftUI
import Series
import Characters
import Comics
import CryptoKit
import MarvelService


struct AppReducer: ReducerProtocol {
    struct State: Equatable, Identifiable {
        let id = "app_id"
        var tab: TabItem = .comics
        var series = SeriesListReducer.State()
        var characters = CharactersListReducer.State()
        var comics = ComicsListReducer.State()
        
        init() {
            let apiParameters = marvelApiParameters()
            self.series.apiParameters = apiParameters
            self.characters.apiParameters = apiParameters
            self.comics.apiParameters = apiParameters
        }
    }
    
    enum TabItem: Int {
        case series
        case characters
        case comics
    }
    
    enum Action: Equatable {
        case onAppear
        case series(SeriesListReducer.Action)
        case characters(CharactersListReducer.Action)
        case comics(ComicsListReducer.Action)
        case tabSelected(TabItem)
    }
    
    var body: some ReducerProtocolOf<Self> {
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
            case .onAppear, .characters, .series:
                break
            case let .tabSelected(tab):
                Haptic.feedback(.selectionChanged)
                state.tab = tab
            case .comics:
                Log.action("\(Self.self) - comics")
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
