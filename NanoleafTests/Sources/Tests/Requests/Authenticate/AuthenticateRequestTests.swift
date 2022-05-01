import XCTest
@testable import Nanoleaf

final class AuthenticateRequestTests: XCTestCase {
    private var session: MockHTTPSession!
    private var apiClient: NanoleafClient!
    
    // MARK: Setup
    
    override func setUpWithError() throws {
        self.session = MockHTTPSession()
        self.apiClient = NanoleafClient.mock(
            session: self.session
        )
    }
    
    // MARK: Tests
    
    func testRequest() async throws {
        self.session.register(
            stub: MockHTTPSession.Stub(
                path: "/api/v1/new",
                method: .post,
                statusCode: 200,
                data: AuthenticateRequest.mock()
            )
        )
        
        let request = AuthenticateRequest(url: URL(string: "https://red.to")!)
        _ = try await self.apiClient.execute(request: request)
    }
}
