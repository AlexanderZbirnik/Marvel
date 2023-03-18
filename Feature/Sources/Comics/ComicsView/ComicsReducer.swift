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
        var characters: PreviewCharactersList?
        var creators: PreviewCreatorsList?
        var links: PreviewLinksList?
        var dates: [PreviewDate] = []
        var prices: [PreviewPrice] = []
        
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
            if let characters = comics.characters, !(characters.items ?? []).isEmpty {
                self.characters = PreviewCharactersList(characters)
            }
            if let creators = comics.creators, !(creators.items ?? []).isEmpty {
                self.creators = PreviewCreatorsList(creators)
            }
            if let links = comics.urls, !links.isEmpty {
                self.links = PreviewLinksList(links)
            }
            if let dates = comics.dates, !dates.isEmpty {
                for date in dates {
                    if let previewDate = PreviewDate.preview(date) {
                        self.dates.append(previewDate)
                    }
                }
            }
            if let prices = comics.prices, !prices.isEmpty {
                for price in prices {
                    if let previewPrice = PreviewPrice.preview(price) {
                        self.prices.append(previewPrice)
                    }
                }
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
