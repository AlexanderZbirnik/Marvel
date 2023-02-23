import Foundation
import CryptoKit

public struct MarvelService {
    public enum ApiKey {
        public static let ts = "ts"
        public static let hash = "hash"
        public static let apiKey = "apikey"
    }
    
    public static func seriesList(_ parameters: [String: String], url: String = "") async -> Result<SeriesDataWrapper, MarvelApiError> {
        var urlString = "https://gateway.marvel.com/v1/public/series?"
        if !url.isEmpty {
            urlString = url
        }
        for (key, value) in parameters {
            urlString += (key + "=" + value)
            urlString += "&"
        }
        urlString.removeLast()
        guard let url = URL(string: urlString) else {
            return .failure(.badUrl)
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return await Self.send(request)
    }
    
    public static func charactersList(_ parameters: [String: String], url: String = "") async -> Result<CharacterDataWrapper, MarvelApiError> {
        var urlString = "https://gateway.marvel.com/v1/public/characters?"
        if !url.isEmpty {
            urlString = url
        }
        for (key, value) in parameters {
            urlString += (key + "=" + value)
            urlString += "&"
        }
        urlString.removeLast()
        guard let url = URL(string: urlString) else {
            return .failure(.badUrl)
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return await Self.send(request)
    }
    
    static func send<T: Decodable>(_ request: URLRequest) async -> Result<T, MarvelApiError> {
      do {
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(T.self, from: data)
        return .success(response)
      } catch {
          return .failure(.error(error))
      }
    }
    
    public static func marvelApiParameters() -> [String: String] {
        guard let filePath = Bundle.main.path(forResource: "Marvel-Info", ofType: "plist") else {
            return [:]
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let publicKey = plist?.object(forKey: "public_key") as? String else {
            return [:]
        }
        guard let privateKey = plist?.object(forKey: "private_key") as? String else {
            return [:]
        }
        let ts = String(Int(Date().timeIntervalSince1970 * 1000.0))
        let totalString = ts + privateKey + publicKey
        guard let data = totalString.data(using: .utf8) else {
            return [:]
        }
        let hash = Insecure.MD5.hash(data: data).map {
            String(format: "%02hhx", $0)
        }.joined()
        return [
            MarvelService.ApiKey.ts: ts,
            MarvelService.ApiKey.apiKey: publicKey,
            MarvelService.ApiKey.hash: hash
        ]
    }
}

public enum MarvelApiError: Error {
    case badUrl
    case error(Error)
}
