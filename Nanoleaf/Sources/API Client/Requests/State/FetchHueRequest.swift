import Foundation

/// Fetch a device's hue.
///
/// A `RangedValue` is returned which will describe the current value and
/// the maximum and minimum the value can be.
public struct FetchHueRequest: HTTPRequest {
    public typealias ResponseObject = RangedValue<Double>
    public typealias ErrorObject = APIError
    
    public let baseURL: URL
    public var method: HTTPMethod { .get }
    public var path: String { "/api/v1/\(self.token)/state/hue" }
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
