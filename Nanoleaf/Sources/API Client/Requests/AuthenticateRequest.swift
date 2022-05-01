import Foundation

/// Authenticate the user with a Nanoleaf device.
///
/// A user is authorized if they can demonstrate physical access to the device.
/// This is achieved by holding the power button down for 5-7 seconds until the LED
/// starts flashing in a pattern.
///
/// Once the LED starts flashing, execute this request within 30 seconds.
public struct AuthenticateRequest: HTTPRequest {
    public typealias ResponseObject = Auth
    public typealias ErrorObject = APIError
    
    public let baseURL: URL
    public var method: HTTPMethod { .post }
    public var path: String { "/api/v1/new" }
    public var isAuthenticated: Bool { false }
    public var body: Data?
    
    // MARK: Initialization
    
    /// Initialize a new instance.
    /// - Parameter baseURL: The device's base URL.
    public init(url: URL) {
        self.baseURL = url
    }
}
