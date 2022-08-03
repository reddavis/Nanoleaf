import Foundation

public struct Rhythm {
    public var id: Int
    public var isConnected: Bool
    public var isActive: Bool
    public var hardwareVersion: String
    public var firmwareVersion: String
    public var isAuxAvailable: Bool
    public var mode: RhythmMode
    public var position: RhythmPosition
}

extension Rhythm: Codable {}

// MARK: Coding keys

extension Rhythm {
    enum CodingKeys: String, CodingKey {
        case id = "rhythmId"
        case isConnected = "rhythmConnected"
        case isActive = "rhythmActive"
        case hardwareVersion
        case firmwareVersion
        case isAuxAvailable = "auxAvailable"
        case mode = "rhythmMode"
        case position = "rhythmPos"
    }
}

// MARK: Fixture

extension Rhythm: Fixture {
    public static func fixture(_ configure: ((inout Self) -> Void)? = nil) -> Self {
        var fixture = Rhythm(
            id: 1,
            isConnected: true,
            isActive: true,
            hardwareVersion: "1.0.0",
            firmwareVersion: "1.0.0",
            isAuxAvailable: true,
            mode: .microphone,
            position: .fixture()
        )
        configure?(&fixture)
        return fixture
    }
}
