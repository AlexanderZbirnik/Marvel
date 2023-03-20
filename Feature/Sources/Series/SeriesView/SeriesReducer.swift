import Foundation
import ComposableArchitecture
import MarvelService
import Common

public struct SeriesReducer: Reducer {
    public struct State: Equatable, Identifiable {
        public var id: Series.Id
        var title = ""
        var detail = ""
        var imageUrl: URL
        var characters: PreviewCharactersList?
        var creators: PreviewCreatorsList?
        var comics: PreviewComicsList?
        
        public init(_ series: Series) {
            self.id = series.id
            self.title = series.title ?? ""
            self.detail = series.description ?? ""
            self.imageUrl =
            MImage.parseThumbnail(series.thumbnail, size: .portraitUncanny)
            if let characters = series.characters, !(characters.items ?? []).isEmpty {
                self.characters = PreviewCharactersList(characters)
            }
            if let creators = series.creators, !(creators.items ?? []).isEmpty {
                self.creators = PreviewCreatorsList(creators)
            }
            if let comics = series.comics, !(comics.items ?? []).isEmpty {
                self.comics = PreviewComicsList(comics)
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
