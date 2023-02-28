import Foundation
import ComposableArchitecture
import MarvelService
import Common

public struct ComicsItemReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id: Comics.Id
        var title = ""
        var imageUrl: URL
        
        public init(_ comics: Comics) {
            self.id = comics.id
            self.title = comics.title ?? ""
            self.imageUrl =
            MImage.parseThumbnail(comics.thumbnail, size: .portraitMedium)
        }
    }
    
    public init() {}
    
    public enum Action: Equatable {
        case onAppear
    }
    
    public var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
