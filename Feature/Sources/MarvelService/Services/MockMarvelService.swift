import Foundation
import Common

public struct MockMarvelService {
    public static func seriesList() async -> SeriesDataWrapper? {
        guard let dataUrl = Bundle.module.url(forResource: "SeriesDataWrapper", withExtension: "json") else {
            return nil
        }
        guard let data = try? Data(contentsOf: dataUrl) else {
            return nil
        }
        return await decode(data: data)
    }
    
    public static func charactersList() async -> CharacterDataWrapper? {
        guard let dataUrl = Bundle.module.url(forResource: "CharacterDataWrapper", withExtension: "json") else {
            return nil
        }
        guard let data = try? Data(contentsOf: dataUrl) else {
            return nil
        }
        return await decode(data: data)
    }
    
    public static func comicsList() async -> ComicsDataWrapper? {
        guard let dataUrl = Bundle.module.url(forResource: "ComicsDataWrapper", withExtension: "json") else {
            return nil
        }
        guard let data = try? Data(contentsOf: dataUrl) else {
            return nil
        }
        return await decode(data: data)
    }
}

func decode<T: Decodable>(data: Data) async -> T? {
    return await withCheckedContinuation { continuation in
        do {
            let object: T? = try JSONDecoder().decode(T.self, from: data)
            return continuation.resume(returning: object)
        } catch _ {
            return continuation.resume(returning: nil)
        }
    }
}
