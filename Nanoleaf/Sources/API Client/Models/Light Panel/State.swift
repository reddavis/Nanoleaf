import Foundation

public struct LightPanelCollectionState {
    public var on: Value<Bool>
    public var brightness: RangedValue<Double>
    public var hue: RangedValue<Double>
    public var saturation: RangedValue<Double>
    public var colorTemperature: RangedValue<Double>
    public var colorMode: ColorMode
}

extension LightPanelCollectionState: Codable {}
extension LightPanelCollectionState: Equatable {}

// MARK: Coding key

extension LightPanelCollectionState {
    enum CodingKeys: String, CodingKey {
        case on
        case brightness
        case hue
        case saturation = "sat"
        case colorTemperature = "ct"
        case colorMode
    }
}

// MARK: Fixture

extension LightPanelCollectionState: Fixture {
    public static func fixture(_ configure: ((inout Self) -> Void)? = nil) -> Self {
        var fixture = LightPanelCollectionState(
            on: .init(value: true),
            brightness: .init(
                value: 5.0,
                max: 10.0,
                min: 0.0
            ),
            hue: .init(
                value: 5.0,
                max: 10.0,
                min: 0.0
            ),
            saturation: .init(
                value: 5.0,
                max: 10.0,
                min: 0.0
            ),
            colorTemperature: .init(
                value: 5.0,
                max: 10.0,
                min: 0.0
            ),
            colorMode: .effect
        )
        configure?(&fixture)
        return fixture
    }
}
