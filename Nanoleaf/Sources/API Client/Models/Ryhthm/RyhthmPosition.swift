import Foundation

public struct RyhthmPosition {
    public var x: Int
    public var y: Int
    public var orientation: Int
}

extension RyhthmPosition: Codable {}

// MARK: Coding keys

extension RyhthmPosition {
    enum CodingKeys: String, CodingKey {
        case x
        case y
        case orientation = "o"
    }
}

// MARK: Fixture

extension RyhthmPosition: Fixture {
    public static func fixture(_ configure: ((inout Self) -> Void)? = nil) -> Self {
        var fixture = RyhthmPosition(
            x: 0,
            y: 0,
            orientation: 0
        )
        configure?(&fixture)
        return fixture
    }
}
