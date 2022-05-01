@testable import Nanoleaf

final class MockHTTPSession {
    weak var taskDelegate: URLSessionTaskDelegate?
    weak var delegate: URLSessionDelegate?
    
    // Private
    private var stubs = [Stub]()
    private var requests = [URLRequest]()
    
    // MARK: Initialization
    
    init() { }
    
    // MARK: Stub responses
    
    func register(stub: Stub) {
        self.stubs.append(stub)
    }
    
    // MARK: Requests
    
    func numberOfRequests(matching path: String) -> Int {
        do {
            let regex = try NSRegularExpression(pattern: path)
            
            return self.requests.filter {
                guard let url = $0.url else { return false }
                return regex.firstMatch(
                    in: url.path,
                    options: [],
                    range: NSRange(location: 0, length: url.path.utf16.count)
                ) != nil
            }.count
        } catch { return 0 }
    }
}

// MARK: HTTPSession

extension MockHTTPSession: HTTPSession {
    func sessionDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> HTTPSessionDataTask {
        let stub = self.stub(for: request)
        self.requests.append(request)
        return MockHTTPSessionDataTask(
            request: request,
            session: self,
            stub: stub,
            completionHandler: completionHandler
        )
    }
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        self.requests.append(request)
        
        guard let stub = self.stub(for: request),
              let url = request.url else {
            throw URLError(.unknown)
        }
        
        let response: URLResponse = HTTPURLResponse(
            url: url,
            statusCode: stub.statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
        
        return (stub.data, response)
    }
    
    private func stub(for request: URLRequest) -> Stub? {
        guard let path = request.url?.path else { return nil }
        
        return self.stubs.first {
            do {
                let regex = try NSRegularExpression(pattern: $0.path)
                return request.httpMethod == $0.method.rawValue && regex.firstMatch(in: path, options: [], range: NSRange(location: 0, length: path.utf16.count)) != nil
            } catch { return false }
        }
    }
}

// MARK: Stub

extension MockHTTPSession {
    struct Stub {
        let path: String
        let method: HTTPMethod
        let statusCode: Int
        let data: Data
        let redirectURL: URL?
        
        // MARK: Initialization
        
        init(
            path: String,
            method: HTTPMethod,
            statusCode: Int,
            data: Data = Data(),
            redirectURL: URL? = nil
        ) {
            self.path = path
            self.method = method
            self.statusCode = statusCode
            self.data = data
            self.redirectURL = redirectURL
        }
    }
}
