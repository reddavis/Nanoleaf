import Foundation

/// Execute an effect command.
///
/// Use this request to:
/// - Add and update animations.
/// - Fetch an effect.
/// - Fetch all effects.
/// - Delete an effect.
/// - Display a preview of an effect.
/// - Rename an effect.
/// - Temporarily display an effect.
/// - Fetch plugins.
public struct ExecuteCommandRequest<T: Decodable>: HTTPRequest {
    public typealias ResponseObject = T
    public typealias ErrorObject = APIError
    
    public let baseURL: URL
    public var method: HTTPMethod { .put }
    public var path: String { "/api/v1/\(self.token)/effects" }
    public var isAuthenticated: Bool { true }
    public var body: Data?
    
    // Private
    private let token: String
    
    // MARK: Initialization
    
    /// Initialize a new instance.
    /// - Parameters:
    ///   - url: The device's URL.
    ///   - token: The device's token.
    ///   - command: The command to execute.
    init(
        url: URL,
        token: String,
        command: Command
    ) throws {
        self.baseURL = url
        self.token = token
        self.body = try Body(
            write: command
        ).encode()
    }
}

// MARK: Body

private struct Body: Encodable {
    var write: Command
}
