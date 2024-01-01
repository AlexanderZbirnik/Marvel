import Foundation
import ComposableArchitecture
import MarvelService
import Common
import Tagged

public struct CharacterReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id: Character.Id
        var name = ""
        var detail = ""
        var imageUrl: URL
        var comics: PreviewComicsList?
        var series: PreviewSeriesList?
        var links: PreviewLinksList?
        
        public init(_ character: Character) {
            self.id = character.id
            self.name = character.name ?? ""
            self.detail = character.description ?? ""
            self.imageUrl =
            MImage.parseThumbnail(character.thumbnail, size: .standardFantastic)
            if let comics = character.comics, !(comics.items ?? []).isEmpty {
                self.comics = PreviewComicsList(comics)
            }
            if let series = character.series, !(series.items ?? []).isEmpty {
                self.series = PreviewSeriesList(series)
            }
            if !character.urls.isEmpty {
                self.links = PreviewLinksList(character.urls)
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
