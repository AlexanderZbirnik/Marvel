import Foundation
import Common

public struct MockMarvelService {
    public static func series() async -> SeriesDataWrapper? {
        guard let dataUrl = Bundle.module.url(forResource: "SeriesDataWrapper", withExtension: "json") else {
            return nil
        }
        Log.action("dataUrl: \(dataUrl)")
        guard let data = try? Data(contentsOf: dataUrl) else {
            return nil
        }
        Log.action("data: \(data)")
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

//func localDiscover() async -> [LearnBlock] {
//    guard let dataUrl = Bundle.module.url(forResource: "discover", withExtension: "json") else {
//        return []
//    }
//    guard let data = try? Data(contentsOf: dataUrl) else {
//        return []
//    }
//    return await decodeDiscover(data: data)
//}

//func decodeDiscover(data: Data) async -> [LearnBlock] {
//    return await withCheckedContinuation { continuation in
//        do {
//            let object: [LearnBlock] = try JSONDecoder().decode([LearnBlock].self, from: data)
//            return continuation.resume(returning: object)
//        } catch _ {
//            return continuation.resume(returning: [])
//        }
//    }
//}
