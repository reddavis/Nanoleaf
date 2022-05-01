import Foundation

/// A Nanoleaf device identifier.
public struct DeviceIdentifier: Codable, Equatable, Hashable {
    /// Device name.
    public var name: String
    
    /// Device type.
    public var type: String
    
    /// Device domain.
    public var domain: String
    
    // MARK: Initialization
    
    /// Initialize a new `DeviceIdentifier` instance.
    /// - Parameters:
    ///   - name: The device's name.
    ///   - type: The device type.
    ///   - domain: The device's domain.
    public init(
        name: String,
        type: String,
        domain: String
    ) {
        self.name = name
        self.type = type
        self.domain = domain
    }
}

// MARK: Fixture

extension DeviceIdentifier: Fixture {
    /// Create a fixture.
    /// - Parameter configure: A closure to configure the fixture.
    /// - Returns: A `Device` instance.
    public static func fixture(_ configure: ((inout Self) -> Void)? = nil) -> Self {
        var fixture = DeviceIdentifier(
            name: "Shapes 999",
            type: "_nanoleafapi._tcp",
            domain: "local."
        )
        configure?(&fixture)
        return fixture
    }
}
