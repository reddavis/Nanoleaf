import Foundation


/// A device's address.
///
/// Use `DeviceAddressResolver` to resolve local a Nanoleaf devices address.
/// Then use the resulting `DeviceAddress` to build requests.
public struct DeviceAddress: Codable, Equatable, Hashable {
    
    /// The device's host name.
    public let hostName: String
    
    /// The device's port.
    public let port: Int
    
    /// The device's URL.
    public var url: URL {
        URL(string: "http://\(self.hostName):\(self.port)")!
    }
}

// MARK: Fixture

extension DeviceAddress: Fixture {
    
    /// Create a fixture.
    /// - Parameter configure: A closure to configure the fixture.
    /// - Returns: A `DeviceAddress` instance.
    public static func fixture(_ configure: ((inout Self) -> Void)? = nil) -> Self {
        var fixture = DeviceAddress(
            hostName: "something.local.",
            port: 1234
        )
        configure?(&fixture)
        return fixture
    }
}
