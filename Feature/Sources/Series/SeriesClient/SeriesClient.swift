import Foundation
import XCTestDynamicOverlay
import Dependencies
import MarvelService

public struct SeriesClient: Sendable {
    public var series: @Sendable([String: String]) async throws -> [Series]
}

extension SeriesClient: TestDependencyKey {
    public static let previewValue = Self(
        series: { _ in
            guard let result = await MockMarvelService.series() else {
                return []
            }
            return result.data?.results ?? []
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
