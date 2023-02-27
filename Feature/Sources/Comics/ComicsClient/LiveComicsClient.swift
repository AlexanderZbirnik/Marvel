import Foundation
import Dependencies
import MarvelService
import Common

extension ComicsClient: DependencyKey {
    public static let liveValue = Self(
        comicsList: { parameters in
            if case let .success(result) = await MarvelService.comicsList(parameters) {
                var comicsList = ComicsList()
                comicsList.attributionHTML =
                result.attributionHTML ?? comicsList.attributionHTML
                comicsList.comics = result.data?.results ?? []
                return comicsList
            }
            return ComicsList()
        }
    )
}
