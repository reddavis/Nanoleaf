import Foundation

extension URLSession: HTTPSession {
    public func sessionDataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> HTTPSessionDataTask {
        self.dataTask(with: request, completionHandler: completionHandler)
    }
    
    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await self.data(for: request, delegate: nil)
    }
}
