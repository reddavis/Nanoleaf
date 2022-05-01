import Foundation

public enum ColorMode: String {
    case effect
    case hueSaturation = "hs"
    case colorTemperature = "ct"
}

extension ColorMode: Codable {}
