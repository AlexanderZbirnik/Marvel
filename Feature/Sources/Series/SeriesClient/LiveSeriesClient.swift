import Foundation
import Dependencies
import MarvelService

extension SeriesClient: DependencyKey {
    public static let liveValue = Self(
        series: { parameters in
            if case let .success(result) = await MarvelService.series(parameters) {
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
