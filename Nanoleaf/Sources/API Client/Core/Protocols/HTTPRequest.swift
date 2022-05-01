import Foundation

/// A protocol for defining a HTTP request.
public protocol HTTPRequest {
    associatedtype ResponseObject//: Any
    associatedtype ErrorObject: Error
    
    /// The base URL.
    var baseURL: URL { get }
    
    /// The URL path.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    /// An array of query items to be appended to the URL path.
    var queryItems: [URLQueryItem]? { get }
    
    /// `Dictionary` of headers.
    var headers: [String : String]? { get }
    
    /// A `TimeInterval` of when the request should timeout.
    var timeout: TimeInterval { get }
    
    /// A `Bool` to indicate whether the request is authenticated or not.
    var isAuthenticated: Bool { get }
    
    /// HTTP body of the request.
    var body: Data? { get set }
    
    /// Processes the response.
    /// - Returns: The response object
    func process(data: Data, response: URLResponse) throws -> ResponseObject
}
