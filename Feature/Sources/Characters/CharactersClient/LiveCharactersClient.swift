import Foundation
import Dependencies
import MarvelService

extension CharactersClient: DependencyKey {
    public static let liveValue = Self(
        charactersList: { parameters in
            if case let .success(result) = await MarvelService.charactersList(parameters) {
                var charactersList = CharactersList()
                charactersList.attributionHTML =
                result.attributionHTML ?? charactersList.attributionHTML
                charactersList.characters = result.data?.results ?? []
                return charactersList
            }
            return CharactersList()
        }
    )
}
