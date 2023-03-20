import Foundation
import ComposableArchitecture
import MarvelService
import Common

public struct SeriesItemReducer: Reducer {
    public struct State: Equatable, Identifiable {
        public var id: Series.Id
        var title = ""
        var imageUrl: URL
        var series: SeriesReducer.State
        
        public init(_ series: Series) {
            self.id = series.id
            self.title = series.title ?? ""
            self.imageUrl =
            MImage.parseThumbnail(series.thumbnail, size: .standardMedium)
            self.series = SeriesReducer.State(series)
        }
    }
    
    public init() {}
    
    public enum Action: Equatable {
        case onAppear
        case series(SeriesReducer.Action)
    }
    
    public var body: some ReducerProtocolOf<Self> {
        Scope(state: \.series, action: /Action.series) {
            SeriesReducer()
        }
        Reduce { state, action in
            switch action {
            case .series:
                Haptic.feedback(.soft)
            default:
                break
            }
            return .none
        }
    }
}
