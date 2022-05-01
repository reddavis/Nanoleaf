import Foundation

/// Causes the panels to flash in unison.
/// This is typically used to help users differentiate between multiple panels.
public struct IdentifyPanelsRequest: HTTPRequest {
    public typealias ResponseObject = Void
    public typealias ErrorObject = APIError
    
    public let baseURL: URL
    public var method: HTTPMethod { .put }
    public var path: String { "/api/v1/\(self.token)/identify" }
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
