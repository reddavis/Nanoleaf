@testable import Nanoleaf

struct MockRequest: HTTPRequest {
    typealias ResponseObject = MockResponse
    typealias ErrorObject = APIError
    
    var baseURL = URL(string: "https://127.0.0.1")!
    var method = HTTPMethod.get
    var path = "/test"
    var isAuthenticated = false
    var body: Data?
}
