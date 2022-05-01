import Foundation

public struct Layout {
    public var orientation: RangedValue<Double>
    public var details: LayoutDetails
}

extension Layout: Codable {}
extension Layout: Equatable {}

// MARK: Coding keys

extension Layout {
    enum CodingKeys: String, CodingKey {
        case orientation = "globalOrientation"
        case details = "layout"
    }
}

// MARK: Fixture

extension Layout: Fixture {
    public static func fixture(_ configure: ((inout Self) -> Void)? = nil) -> Self {
        var fixture = Layout(
            orientation: .init(
                value: 0.5,
                max: 10.0,
                min: 0.0
            ),
            details: .fixture()
        )
        configure?(&fixture)
        return fixture
    }
}
