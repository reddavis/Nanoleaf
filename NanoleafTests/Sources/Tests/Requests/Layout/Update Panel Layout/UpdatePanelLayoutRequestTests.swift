import XCTest
@testable import Nanoleaf

class UpdatePanelLayoutRequestTests: XCTestCase {
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
                path: "/api/v1/\(token)/panelLayout",
                method: .put,
                statusCode: 200,
                data: .init()
            )
        )
        
        let request = try UpdatePanelLayoutRequest(
            url: URL(string: "https://red.to")!,
            token: token,
            globalOrientation: 240.0
        )
        
        _ = try await self.apiClient.execute(request: request)
    }
}
