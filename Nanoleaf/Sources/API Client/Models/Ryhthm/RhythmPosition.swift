import Foundation

public struct RhythmPosition {
    public var x: Int
    public var y: Int
    public var orientation: Int
}

extension RhythmPosition: Codable {}

// MARK: Coding keys

extension RhythmPosition {
    enum CodingKeys: String, CodingKey {
        case x
        case y
        case orientation = "o"
    }
}

// MARK: Fixture

extension RhythmPosition: Fixture {
    public static func fixture(_ configure: ((inout Self) -> Void)? = nil) -> Self {
        var fixture = RhythmPosition(
            x: 0,
            y: 0,
            orientation: 0
        )
        configure?(&fixture)
        return fixture
    }
}
