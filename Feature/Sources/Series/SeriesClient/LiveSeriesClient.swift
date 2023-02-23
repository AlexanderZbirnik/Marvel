import Foundation
import Dependencies
import MarvelService

extension SeriesClient: DependencyKey {
    public static let liveValue = Self(
        seriesList: { parameters, url in
            if case let .success(result) = await MarvelService.seriesList(parameters, url: url) {
                var seriesList = SeriesList()
                seriesList.attributionHTML =
                result.attributionHTML ?? seriesList.attributionHTML
                seriesList.series = result.data?.results ?? []
                return seriesList
            }
            return SeriesList()
        }
    )
}
