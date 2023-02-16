import Foundation
import ComposableArchitecture
import MarvelService
import Common

public struct SeriesItemReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id: Series.Id
        var title = ""
        var imageUrl: URL
        var series: SeriesReducer.State
        
        public init(_ series: Series) {
            self.id = series.id
            self.title = series.title ?? ""
            self.imageUrl = Self.parseThumbnail(series.thumbnail)
            self.series = SeriesReducer.State(series)
        }
        
        static func parseThumbnail(_ image: MImage?) -> URL {
            if var path = image?.path {
                path = path.replacingOccurrences(of: "http:", with: "https:")
                path += "/standard_medium"
                if let ext = image?.extension {
                    path += ("." + ext)
                } else {
                    path += ".jpg"
                }
                if let url = URL(string: path) {
                    return url
                } else {
                    return URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/standard_medium.jpg")!
                }
            } else {
                return URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/standard_medium.jpg")!
            }
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
            case .onAppear, .series:
                return .none
            }
        }
    }
}
