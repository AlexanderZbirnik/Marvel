import Foundation
import XCTestDynamicOverlay
import Dependencies
import MarvelService

public struct CharactersClient: Sendable {
    public var charactersList: @Sendable([String: String]) async throws -> CharactersList
}

extension CharactersClient: TestDependencyKey {
    public static let previewValue = Self(
        charactersList: { _ in
            guard let result = await MockMarvelService.charactersList() else {
                return CharactersList()
            }
            var charactersList = CharactersList()
            charactersList.attributionHTML =
            result.attributionHTML ?? charactersList.attributionHTML
            charactersList.characters = result.data?.results ?? []
            return charactersList
        }
    )
    
    public static let testValue = Self(
        charactersList: XCTUnimplemented("\(Self.self).charactersList")
    )
}

public extension DependencyValues {
    var charactersClient: CharactersClient {
        get { self[CharactersClient.self] }
        set { self[CharactersClient.self] = newValue }
    }
}
