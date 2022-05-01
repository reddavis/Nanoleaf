import Foundation

public struct PanelPosition {
    public var id: Int
    public var x: Int
    public var y: Int
    public var orientation: Int
    public var shapeType: ShapeType
}

extension PanelPosition: Codable {}
extension PanelPosition: Equatable {}

// MARK: Coding keys

extension PanelPosition {
    enum CodingKeys: String, CodingKey {
        case id = "panelId"
        case x
        case y
        case orientation = "o"
        case shapeType
    }
}

// MARK: Fixture

extension PanelPosition: Fixture {
    public static func fixture(_ configure: ((inout Self) -> Void)? = nil) -> Self {
        var fixture = PanelPosition(
            id: 1,
            x: 1,
            y: 1,
            orientation: 1,
            shapeType: .triangle
        )
        configure?(&fixture)
        return fixture
    }
}
