import Foundation

/// Fetch a device's color mode.
///
/// A `ColorMode` is returned.
public struct FetchColorModeRequest: HTTPRequest {
    public typealias ResponseObject = ColorMode
    public typealias ErrorObject = APIError
    
    public let baseURL: URL
    public var method: HTTPMethod { .get }
    public var path: String { "/api/v1/\(self.token)/state/colorMode" }
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
