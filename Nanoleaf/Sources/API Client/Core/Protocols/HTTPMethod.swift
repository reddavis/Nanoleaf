import Foundation

public enum HTTPMethod: String, Codable {
    /// `GET` method.
    case get = "GET"
    
    /// `POST` method.
    case post = "POST"
    
    /// `DELETE` method.
    case delete = "DELETE"
    
    /// `PUT` method.
    case put = "PUT"
    
    /// `HEAD` method.
    case head = "HEAD"
    
    /// `TRACE` method.
    case track = "TRACE"
    
    /// `PATCH` method.
    case patch = "PATCH"
    
    /// `OPTIONS` method.
    case options = "OPTIONS"
    
    /// `CONNECT` method.
    case connect = "CONNECT"
}
