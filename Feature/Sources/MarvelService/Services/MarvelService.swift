import Foundation

public struct MarvelService {
    public enum ApiKey {
        public static let ts = "ts"
        public static let hash = "hash"
        public static let apiKey = "apikey"
    }
    
    public static func seriesList(_ parameters: [String: String]) async -> Result<SeriesDataWrapper, MarvelApiError> {
        let url = "https://gateway.marvel.com/v1/public/series?"
        switch await Self.request(parameters, url: url) {
        case let .success(request):
            return await Self.send(request)
        case let .failure(error):
            return.failure(error)
        }
    }
    
    public static func charactersList(_ parameters: [String: String]) async -> Result<CharacterDataWrapper, MarvelApiError> {
        let url = "https://gateway.marvel.com/v1/public/characters?"
        switch await Self.request(parameters, url: url) {
        case let .success(request):
            return await Self.send(request)
        case let .failure(error):
            return.failure(error)
        }
    }
    
    public static func comicsList(_ parameters: [String: String]) async -> Result<ComicsDataWrapper, MarvelApiError> {
        let url = "https://gateway.marvel.com/v1/public/comics?"
        switch await Self.request(parameters, url: url) {
        case let .success(request):
            return await Self.send(request)
        case let .failure(error):
            return.failure(error)
        }
    }
    
    static func request(_ parameters: [String: String], url: String) async -> Result<URLRequest, MarvelApiError> {
        var urlString = url
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
        return .success(request)
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
