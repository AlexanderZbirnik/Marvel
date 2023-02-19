import Foundation
import ComposableArchitecture
import MarvelService
import Common

public struct SeriesReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id: Series.Id
        var title = ""
        var detail = ""
        var imageUrl: URL
        var characters: SeriesCharactersList?
        
        public init(_ series: Series) {
            self.id = series.id
            self.title = series.title ?? ""
            self.detail = series.description ?? ""
            self.imageUrl = Self.parseThumbnail(series.thumbnail)
            if let characters = series.characters, !(characters.items ?? []).isEmpty {
                self.characters = SeriesCharactersList(characters)
            }
        }
        
        static func parseThumbnail(_ image: MImage?) -> URL {
            if var path = image?.path {
                path = path.replacingOccurrences(of: "http:", with: "https:")
                path += "/portrait_uncanny"
                if let ext = image?.extension {
                    path += ("." + ext)
                } else {
                    path += ".jpg"
                }
                if let url = URL(string: path) {
                    return url
                } else {
                    return URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/portrait_uncanny.jpg")!
                }
            } else {
                return URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/portrait_uncanny.jpg")!
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
