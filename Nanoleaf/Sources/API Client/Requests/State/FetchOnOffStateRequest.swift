import Foundation

/// Fetch a device's on/off state.
///
/// A `Value<Bool>` is returned.
public struct FetchOnOffStateRequest: HTTPRequest {
    public typealias ResponseObject = Value<Bool>
    public typealias ErrorObject = APIError
    
    public let baseURL: URL
    public var method: HTTPMethod { .get }
    public var path: String { "/api/v1/\(self.token)/state/on" }
    public var isAuthenticated: Bool { true }
    public var body: Data?
    
    // Private
    private let token: String
    
    // MARK: Initialization
    
    /// Initialize a new instance.
    /// - Parameters:
    ///   - url: The device's URL.
    ///   - token: The device's token.
    public init(
        url: URL,
        token: String
    ) {
        self.baseURL = url
        self.token = token
    }
}
