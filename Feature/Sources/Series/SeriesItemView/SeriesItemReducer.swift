import Foundation
import ComposableArchitecture
import MarvelService
import Common

public struct SeriesItemReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id: Series.Id
        var title = ""
        var years = ""
        var imageUrl: URL
        
        public init(_ series: Series) {
            self.id = series.id
            self.title = series.title ?? ""
            var years = ""
            if let startYear = series.startYear {
                years = "\(startYear)"
            }
            if let endYear = series.endYear, endYear != (series.startYear ?? 0) {
                years += endYear == 2099 ? " - ..." : " - \(endYear)"
            }
            self.years = years
            if var path = series.thumbnail?.path {
                path = path.replacingOccurrences(of: "http:", with: "https:")
                path += "/standard_medium"
                if let ext = series.thumbnail?.extension {
                    path += ("." + ext)
                } else {
                    path += ".jpg"
                }
                if let url = URL(string: path) {
                    self.imageUrl = url
                } else {
                    self.imageUrl = URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/standard_medium.jpg")!
                }
            } else {
                self.imageUrl = URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/standard_medium.jpg")!
            }
        }
    }
    
    public init() {}
    
    public enum Action: Equatable {
        case onAppear
    }
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            return .none
        }
    }
}
