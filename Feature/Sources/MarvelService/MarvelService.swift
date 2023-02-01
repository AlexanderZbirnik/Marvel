import Foundation

public struct MarvelService {
    public enum ApiKey {
        public static let ts = "ts"
        public static let hash = "hash"
        public static let apiKey = "apikey"
    }
    
    public static func series(_ parameters: [String: String]) async -> Result<SeriesDataWrapper, MarvelApiError> {
        var urlString = "https://gateway.marvel.com/v1/public/series?"
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
}

public enum MarvelApiError: Error {
    case badUrl
    case error(Error)
}
