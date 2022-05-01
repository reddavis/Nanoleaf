import Foundation

/// Resolves a device found via Bonjour.
///
/// After using `NanoleafDeviceBrowser` to find local Nanoleaf devices,
/// use this class to resolve a device's hostname and port.
public final class DeviceAddressResolver: NSObject {
    private let domain: String
    private let type: String
    private let name: String
    
    private var service: NetService?
    private var continuation: CheckedContinuation<DeviceAddress, Error>?
    
    // MARK: Initialization
    
    /// Initialize a new `DeviceAddressResolver` instance.
    /// - Parameters:
    ///   - domain: The device's domain.
    ///   - type: The device's type.
    ///   - name: The device's name.
    public init(
        domain: String,
        type: String,
        name: String
    ) {
        self.domain = domain
        self.type = type
        self.name = name
        
        super.init()
    }
    
    /// Initialize a new `DeviceAddressResolver` instance.
    /// - Parameter device: The device identifier to resolve.
    public convenience init(identifier: DeviceIdentifier) {
        self.init(
            domain: identifier.domain,
            type: identifier.type,
            name: identifier.name
        )
    }
    
    // MARK: Resolution
    
    /// Resolve the device's address.
    /// - Throws: An error of type `DeviceAddressResolverError`.
    /// - Returns: A `DeviceAddress` instance.
    public func resolve() async throws -> DeviceAddress {
        try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            
            DispatchQueue.main.async {
                self.service = NetService(
                    domain: self.domain,
                    type: self.type,
                    name: self.name
                )
                self.service?.delegate = self
                self.service?.resolve(withTimeout: 10)
            }
        }
    }
}

// MARK: NetServiceDelegate

extension DeviceAddressResolver: NetServiceDelegate {
    public func netServiceDidResolveAddress(_ sender: NetService) {
        guard let hostName = sender.hostName else {
            self.continuation?.resume(throwing: DeviceAddressResolverError.failedToResolve)
            return
        }
        
        self.continuation?.resume(
            returning: .init(
                hostName: hostName,
                port: sender.port
            )
        )
    }
    
    public func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        self.continuation?.resume(throwing: DeviceAddressResolverError.failedToResolve)
    }
}

// MAKR: Error

public enum DeviceAddressResolverError: Error {
    case failedToResolve
}
