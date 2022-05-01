import Foundation

public struct Device {
    public var name: String
    public var serialNumber: String
    public var manufacturer: String
    public var firmwareVersion: String
    public var model: String
    public var state: LightPanelCollectionState
    public var layout: Layout
    public var effectList: EffectList
}

extension Device: Codable {}
extension Device: Equatable {}

// MARK: Coding keys

extension Device {
    enum CodingKeys: String, CodingKey {
        case name
        case serialNumber = "serialNo"
        case manufacturer
        case firmwareVersion
        case model
        case state
        case layout = "panelLayout"
        case effectList = "effects"
    }
}

// MARK: Fixture

extension Device: Fixture {
    public static func fixture(_ configure: ((inout Self) -> Void)? = nil) -> Self {
        var fixture = Device(
            name: "Fixture",
            serialNumber: "123",
            manufacturer: "Nanoleaf",
            firmwareVersion: "1.0.0",
            model: "Pizza slice",
            state: .fixture(),
            layout: .fixture(),
            effectList: .fixture()
        )
        configure?(&fixture)
        return fixture
    }
}
