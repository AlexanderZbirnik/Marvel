import ComposableArchitecture
import Common
import SwiftUI
import Series
import Characters
import CryptoKit
import MarvelService

struct AppReducer: ReducerProtocol {
    struct State: Equatable, Identifiable {
        let id = "app_id"
        var tab: TabItem = .series
        var series = SeriesListReducer.State()
        var characters = CharactersReducer.State()
        
        init() {
            let apiParameters = marvelApiParameters()
            self.series.apiParameters = apiParameters
            self.characters.apiParameters = apiParameters
        }
    }
    
    enum TabItem: Int {
        case series
        case characters
    }
    
    enum Action: Equatable {
        case onAppear
        case series(SeriesListReducer.Action)
        case characters(CharactersReducer.Action)
        case tabSelected(TabItem)
    }
    
    var body: some ReducerProtocolOf<Self> {
        Scope(state: \.series, action: /Action.series) {
            SeriesListReducer()
        }
        Scope(state: \.characters, action: /Action.characters) {
            CharactersReducer()
        }
        Reduce { state, action in
            switch action {
            case .onAppear:
                Log.action("AppReducer - onAppear")
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

