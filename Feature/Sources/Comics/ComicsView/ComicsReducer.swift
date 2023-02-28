import Foundation
import ComposableArchitecture
import MarvelService
import Common

public struct ComicsReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id: Comics.Id
        var title = ""
        var detail = ""
        var imageUrl: URL
        var isbn = ""
        var ean = ""
        var upc = ""
        var diamondCode = ""
        var format = ""
        var pageCount = 0
        var series: PreviewSeriesList?
        var characters: PreviewCharactersList?
//        var creators: SeriesCreatorsList?
//        var links: PreviewLinksList?
        
        public init(_ comics: Comics) {
            self.id = comics.id
            self.title = comics.title ?? ""
            self.detail = comics.description ?? ""
            self.imageUrl =
            MImage.parseThumbnail(comics.thumbnail, size: .portraitUncanny)
            self.isbn = comics.isbn ?? ""
            self.ean = comics.ean ?? ""
            self.upc = comics.upc ?? ""
            self.diamondCode = comics.diamondCode ?? ""
            self.format = comics.format ?? ""
            self.pageCount = comics.pageCount ?? 0
            if let series = comics.series, !(series.items ?? []).isEmpty {
                self.series = PreviewSeriesList(series)
            }
            if let characters = comics.characters, !(characters.items ?? []).isEmpty {
                self.characters = PreviewCharactersList(characters)
            }
//            if !character.urls.isEmpty {
//                self.links = PreviewLinksList(character.urls)
//            }
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
