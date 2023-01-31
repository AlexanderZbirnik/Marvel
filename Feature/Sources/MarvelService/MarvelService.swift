import Foundation

public struct MarvelService {
    public enum ApiKey {
        public static let ts = "ts"
        public static let hash = "hash"
        public static let apiKey = "apikey"
    }
    
    public static func series(_ parameters: [String: String]) async {
        var urlString = "https://gateway.marvel.com/v1/public/series?"
        for (key, value) in parameters {
            urlString += (key + "=" + value)
            urlString += "&"
        }
        urlString.removeLast()
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
            print("response: \(response)")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
    }
}
