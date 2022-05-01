import Foundation

/// A shell protocol. Primarily used to make testing easier.
public protocol HTTPSession {
    var delegate: URLSessionDelegate? { get }
    func sessionDataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> HTTPSessionDataTask
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
