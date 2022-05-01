import Foundation

/// Update a device's panel layout.
public struct UpdatePanelLayoutRequest: HTTPRequest {
    public typealias ResponseObject = Void
    public typealias ErrorObject = APIError
    
    public let baseURL: URL
    public var method: HTTPMethod { .put }
    public var path: String { "/api/v1/\(self.token)/panelLayout" }
    public var isAuthenticated: Bool { true }
    public var body: Data?
    
    // Private
    private let token: String
    
    // MARK: Initialization
    
    public init(
        url: URL,
        token: String,
        globalOrientation: Double
    ) throws {
        self.baseURL = url
        self.token = token
        self.body = try Body(
            globalOrientation: .init(value: globalOrientation)
        ).encode()
    }
}

// MARK: Body

private struct Body: Codable {
    var globalOrientation: Value<Double>? = nil
}
