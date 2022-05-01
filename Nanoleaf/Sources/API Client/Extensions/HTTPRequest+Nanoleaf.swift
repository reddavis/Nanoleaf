import Foundation

extension HTTPRequest {
    public var method: HTTPMethod { .get }
    public var queryItems: [URLQueryItem]? { nil }
    public var headers: [String : String]? { nil }
    public var timeout: TimeInterval { 30.0 }
}

// MARK: Error construction

extension HTTPRequest {
    func buildError(response: HTTPURLResponse) -> APIError {
        APIError(statusCode: response.statusCode)
    }
}

// MARK: Default processing where ErrorObject == APIError, ResponseObject: Decodable

extension HTTPRequest where ErrorObject == APIError, ResponseObject: Decodable {
    public func process(data: Data, response: URLResponse) throws -> ResponseObject {
        guard let response = response as? HTTPURLResponse else {
            throw APIError.unknown(message: "Response is not a HTTPURLResponse")
        }
        guard response.isSuccess else {
            throw self.buildError(response: response)
        }
        
        do {
            let decoder = JSONDecoder.nanoleaf
            let response = try decoder.decode(ResponseObject.self, from: data)
            return response
        } catch {
            throw APIError.invalidJSON(message: "\(error.localizedDescription)")
        }
    }
}

// MARK: Default processing where ErrorObject == APIError, ResponseObject == Void

extension HTTPRequest where ErrorObject == APIError, ResponseObject == Void {
    public func process(data: Data, response: URLResponse) throws -> ResponseObject {
        guard let response = response as? HTTPURLResponse else {
            throw APIError.unknown(message: "Response is not a HTTPURLResponse")
        }
        guard response.isSuccess else {
            throw self.buildError(response: response)
        }
        
        return Void()
    }
}
