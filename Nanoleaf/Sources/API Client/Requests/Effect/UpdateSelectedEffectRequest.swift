import Foundation

/// Select an effect.
///
/// Use `FetchEffectsRequest` to fetch a list of available effects.
public struct UpdateSelectedEffectRequest: HTTPRequest {
    public typealias ResponseObject = Void
    public typealias ErrorObject = APIError
    
    public let baseURL: URL
    public var method: HTTPMethod { .put }
    public var path: String { "/api/v1/\(self.token)/effects/select" }
    public var isAuthenticated: Bool { true }
    public var body: Data?
    
    // Private
    private let token: String
    
    // MARK: Initialization
    
    /// Initialize a new instance.
    /// - Parameters:
    ///   - url: The device's URL.
    ///   - token: The device's token.
    ///   - effect: The effect to set.
    public init(
        url: URL,
        token: String,
        effect: String
    ) throws {
        self.baseURL = url
        self.token = token
        self.body = try Body(
            select: effect
        ).encode()
    }
}

// MARK: Body

private struct Body: Codable {
    var select: String
}
