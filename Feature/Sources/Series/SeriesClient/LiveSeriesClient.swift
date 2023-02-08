import Foundation
import Dependencies
import MarvelService

extension SeriesClient: DependencyKey {
    public static let liveValue = Self(
        series: { parameters in
            if case let .success(result) = await MarvelService.series(parameters) {
                return result.data?.results ?? []
            }
            return []
        }
    )
}
