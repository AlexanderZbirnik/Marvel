import Foundation
import XCTestDynamicOverlay
import Dependencies
import MarvelService

public struct SeriesClient: Sendable {
    public var series: @Sendable([String: String]) async throws -> SeriesList
}

extension SeriesClient: TestDependencyKey {
    public static let previewValue = Self(
        series: { _ in
            guard let result = await MockMarvelService.series() else {
                return SeriesList()
            }
            var seriesList = SeriesList()
            seriesList.attributionHTML =
            result.attributionHTML ?? seriesList.attributionHTML
            seriesList.series = result.data?.results ?? []
            return seriesList
        }
    )
    
    public static let testValue = Self(
        series: XCTUnimplemented("\(Self.self).series")
    )
}

public extension DependencyValues {
    var seriesClient: SeriesClient {
        get { self[SeriesClient.self] }
        set { self[SeriesClient.self] = newValue }
    }
}
