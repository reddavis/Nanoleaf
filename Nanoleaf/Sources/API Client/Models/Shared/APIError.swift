import Foundation

public struct APIError {
    static func invalidJSON(message: String) -> APIError {
        APIError(status: .invalidJSON, message: message)
    }
    
    static func unknown(message: String) -> APIError {
        APIError(status: .unknown, message: message)
    }
    
    // Public
    public let status: APIErrorStatus
    public let message: String
    public var errorDescription: String? { self.message }
    
    // MARK: Initialization
    
    init(statusCode: Int, message: String? = nil) {
        self.status = APIErrorStatus(rawValue: statusCode) ?? .unknown
        self.message = message ?? self.status.description
    }
    
    init(status: APIErrorStatus, message: String? = nil) {
        self.status = status
        self.message = message ?? self.status.description
    }
}

extension APIError: LocalizedError {}
extension APIError: Codable {}
extension APIError: Equatable {}

// MARK: Error status

public enum APIErrorStatus: Int {
    case unknown = -1
    case invalidJSON = -2
    case badRequest = 400
    case unauthorized = 401
    case notFound = 404
    case unprocessibleEntity = 422
    case serverError = 500
    
    // MARK: Description
    
    var description: String {
        switch self {
        case .unknown:
            return "Unknown error"
        case .invalidJSON:
            return "Invalid JSON"
        case .badRequest:
            return "Bad request"
        case .unauthorized:
            return "Unauthorized"
        case .notFound:
            return "Resource not found"
        case .unprocessibleEntity:
            return "Unprocessible entity"
        case .serverError:
            return "Internal server error"
        }
    }
}

extension APIErrorStatus: Codable {}
