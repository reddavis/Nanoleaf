import Foundation

public enum RyhthmMode: Int {
    case microphone = 0
    case aux = 1
}

extension RyhthmMode: Codable {}
