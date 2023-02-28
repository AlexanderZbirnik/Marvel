import Foundation
import ComposableArchitecture
import MarvelService
import Common

public struct ComicsItemReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id: Comics.Id
        var title = ""
        var imageUrl: URL
        var comics: ComicsReducer.State
        
        public init(_ comics: Comics) {
            self.id = comics.id
            self.title = comics.title ?? ""
            self.imageUrl =
            MImage.parseThumbnail(comics.thumbnail, size: .portraitMedium)
            self.comics = ComicsReducer.State(comics)
        }
    }
    
    public init() {}
    
    public enum Action: Equatable {
        case onAppear
        case comics(ComicsReducer.Action)
    }
    
    public var body: some ReducerProtocolOf<Self> {
        Scope(state: \.comics, action: /Action.comics) {
            ComicsReducer()
        }
        Reduce { state, action in
            return .none
        }
    }
}
