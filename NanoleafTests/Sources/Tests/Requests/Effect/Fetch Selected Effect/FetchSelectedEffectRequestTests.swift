import XCTest
@testable import Nanoleaf

class FetchSelectedEffectRequestTests: XCTestCase {
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
        let token = "abc"
        self.session.register(
            stub: MockHTTPSession.Stub(
                path: "/api/v1/\(token)/effects/select",
                method: .get,
                statusCode: 200,
                data: FetchSelectedEffectRequest.mock()
            )
        )
        
        let request = FetchSelectedEffectRequest(
            url: URL(string: "https://red.to")!,
            token: token
        )
        
        _ = try await self.apiClient.execute(request: request)
    }
}
