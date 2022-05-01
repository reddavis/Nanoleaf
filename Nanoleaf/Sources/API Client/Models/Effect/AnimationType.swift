import Foundation

public enum AnimationType: String {
    case random
    case flow
    case wheel
    case fade
    case highlight
    case custom
    case `static`
    case plugin
    case solid
    case externalControl = "extControl"
    case explode
}

extension AnimationType: Codable {}
