import Foundation

public struct LayoutDetails {
    public var numberOfPanels: Int
    public var sideLength: Int
    public var positions: [PanelPosition]
}

extension LayoutDetails: Codable {}
extension LayoutDetails: Equatable {}

// MARK: Coding keys

extension LayoutDetails {
    enum CodingKeys: String, CodingKey {
        case numberOfPanels = "numPanels"
        case sideLength
        case positions = "positionData"
    }
}

// MARK: Fixture

extension LayoutDetails: Fixture {
    public static func fixture(_ configure: ((inout Self) -> Void)? = nil) -> Self {
        var fixture = LayoutDetails(
            numberOfPanels: 2,
            sideLength: 200,
            positions: [
                .fixture(),
                .fixture()
            ]
        )
        configure?(&fixture)
        return fixture
    }
}
