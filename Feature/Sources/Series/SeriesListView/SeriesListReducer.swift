import Foundation
import ComposableArchitecture
import MarvelService
import Common

public struct SeriesListReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id = "series_id"
        public var apiParameters: [String: String] = [:]
        var firstOnAppear = true
        var seriesItems: IdentifiedArrayOf<SeriesItemReducer.State> = []
        var copyright = AttributedString()
        
        public init() {}
    }
    
    public init() {}
    
    public enum Action: Equatable {
        case onAppear
        case loadSeries
        case seriesLoaded(SeriesList)
        case seriesItem(id: Series.Id, action: SeriesItemReducer.Action)
    }
    
    @Dependency(\.seriesClient) var seriesClient
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                if state.firstOnAppear {
                    state.firstOnAppear = false
                    return .task { [parameters = state.apiParameters] in
                            .seriesLoaded(try await seriesClient.series(parameters))
                    }
                }
                return .none
            case .loadSeries:
                Log.action("\(Self.self) - onAppear")
            case let .seriesLoaded(seriesList):
                if let data = seriesList.attributionHTML.data(using: .unicode),
                   let attributedString =
                    try? NSAttributedString(data: data,
                                            options: [.documentType: NSAttributedString.DocumentType.html],
                                            documentAttributes: nil) {
                    state.copyright = AttributedString(attributedString)
                    state.copyright.foregroundColor = Palette.red
                    state.copyright.font = .callout
                }
                var seriesItems: IdentifiedArrayOf<SeriesItemReducer.State> = []
                for series in seriesList.series {
                    seriesItems.append(SeriesItemReducer.State(series))
                }
                state.seriesItems = seriesItems
            case let .seriesItem(id, _):
                Log.action("\(Self.self) - seriesItem id: \(id)")
                Haptic.feedback(.soft)
            }
            return .none
        }
        .forEach(\.seriesItems, action: /Action.seriesItem(id:action:)) {
            SeriesItemReducer()
        }
    }
}
