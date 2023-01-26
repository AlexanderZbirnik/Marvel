import Foundation

private let IS_DISABLED = false

public struct Log {
    public static func error(_ message: String) {
    Log.aprint(message, emoji: "⛔")
  }
  
    public static func attention(_ message: String) {
    Log.aprint(message, emoji: "⚠️")
  }
  
    public static func action(_ message: String) {
    Log.aprint(message, emoji: "✅")
  }
  
    public static func success(_ message: String, object: Any? = nil) {
    let totalMessage: String
    if let anyObject = object {
      totalMessage = "Success \(message): \(anyObject)"
    } else {
      totalMessage = "Success \(message)"
    }
    Log.aprint(totalMessage, emoji: "⭐️")
  }
  
    public static func failure(_ message: String, object: Any? = nil) {
    let totalMessage: String
    if let anyObject = object {
      totalMessage = "Failure \(message): \(anyObject)"
    } else {
      totalMessage = "Failure \(message): Unknown error"
    }
    Log.aprint(totalMessage, emoji: "❌")
  }
  
    public static func aprint(_ text: String, emoji: String = "") {
    if IS_DISABLED {
      return
    }
    var message = "\n-------------------------------------------------------------\n"
    message += "\(emoji) [\(currentDate())] \(text)\n"
    message += "-------------------------------------------------------------\n"
#if DEBUG
    print(message)
#endif
  }
  
  private static func currentDate() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss.SSS"
    return formatter.string(from: Date())
  }
}

