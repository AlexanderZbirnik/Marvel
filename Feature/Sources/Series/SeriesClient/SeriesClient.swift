import Foundation
import XCTestDynamicOverlay
import Dependencies
import MarvelService

public struct SeriesClient: Sendable {
    public var seriesList: @Sendable([String: String], String) async throws -> SeriesList
}

extension SeriesClient: TestDependencyKey {
    public static let previewValue = Self(
        seriesList: { _, _ in
            guard let result = await MockMarvelService.seriesList() else {
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
        seriesList: XCTUnimplemented("\(Self.self).seriesList")
    )
}

public extension DependencyValues {
    var seriesClient: SeriesClient {
        get { self[SeriesClient.self] }
        set { self[SeriesClient.self] = newValue }
    }
}
