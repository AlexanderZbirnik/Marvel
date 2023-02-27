import Foundation
import XCTestDynamicOverlay
import Dependencies
import MarvelService

public struct ComicsClient: Sendable {
    public var comicsList: @Sendable([String: String]) async throws -> ComicsList
}

extension ComicsClient: TestDependencyKey {
    public static let previewValue = Self(
        comicsList: { _ in
            guard let result = await MockMarvelService.comicsList() else {
                return ComicsList()
            }
            var comicsList = ComicsList()
            comicsList.attributionHTML =
            result.attributionHTML ?? comicsList.attributionHTML
            comicsList.comics = result.data?.results ?? []
            return comicsList
        }
    )
    
    public static let testValue = Self(
        comicsList: XCTUnimplemented("\(Self.self).comicsList")
    )
}

public extension DependencyValues {
    var comicsClient: ComicsClient {
        get { self[ComicsClient.self] }
        set { self[ComicsClient.self] = newValue }
    }
}
