import Foundation

/// Fetch a device's global orientation.
///
/// The global orientation can be a value between 0 and 360.
public struct FetchGlobalOrientationRequest: HTTPRequest {
    public typealias ResponseObject = RangedValue<Double>
    public typealias ErrorObject = APIError
    
    public let baseURL: URL
    public var method: HTTPMethod { .get }
    public var path: String { "/api/v1/\(self.token)/panelLayout/globalOrientation" }
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
