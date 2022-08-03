import Foundation

public enum RhythmMode: Int {
    case microphone = 0
    case aux = 1
}

extension RhythmMode: Codable {}
