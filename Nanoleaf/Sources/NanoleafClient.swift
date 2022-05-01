import Foundation

/// An API client that sends requests to Nanoleaf devices.
public final class NanoleafClient {
    public let session: HTTPSession
    
    // Private
    private let logger = Logger(subsystem: "com.reddavis.Nanoleaf", category: "Nanoleaf")
    
    private let defaultHeaders = [
        "Content-Type" : "application/json"
    ]
    
    // MARK: Initialization
    
    /// Initialize a new `NanoleafClient` instance.
    /// - Parameters:
    ///   - session: A `HTTPSession` instance.
    public required init(session: HTTPSession) {
        self.session = session
    }
    
    // MARK: Request
    
    /// Execute a request.
    /// - Throws: An error of type `APIError`.
    /// - Returns: The HTTPRequest's response object.
    public func execute<T: HTTPRequest>(request: T) async throws -> T.ResponseObject {
        let urlRequest = self.urlRequest(for: request)
        let (data, response) = try await self.session.data(for: urlRequest)
        
        return try request.process(data: data, response: response)
    }
    
    private func urlRequest<T: HTTPRequest>(for request: T) -> URLRequest {
        var urlComponents = URLComponents(url: request.baseURL, resolvingAgainstBaseURL: false)!
        urlComponents.path = request.path
        urlComponents.queryItems = request.queryItems
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        urlRequest.timeoutInterval = request.timeout
        
        return urlRequest
    }
}

// MARK: Helpers

extension NanoleafClient {
    public static func main(
        session: HTTPSession = URLSession(configuration: .default)
    ) -> Self {
        .init(session: session)
    }
}
