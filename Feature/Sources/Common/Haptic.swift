import UIKit
import AudioToolbox
import CoreHaptics

public struct Haptic {
    public enum Feedback {
        case error
        case success
        case warning
        case light
        case medium
        case heavy
        case soft
        case rigid
        case selectionChanged
    }
    
    private var engine: CHHapticEngine?
    
    public init() {
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    public static func feedback(_ feedback: Feedback) {
        switch feedback {
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        case .success:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        case .warning:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        case .light:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        case .medium:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        case .heavy:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        case .soft:
            let generator = UIImpactFeedbackGenerator(style: .soft)
            generator.impactOccurred()
        case .rigid:
            let generator = UIImpactFeedbackGenerator(style: .rigid)
            generator.impactOccurred()
        case .selectionChanged:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
    }
    
    public func buzz() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        guard engine != nil else { return }
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0.0, duration: 1.1)
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0.0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}
