import XCTest
@testable import Nanoleaf

class FetchPanelLayoutRequestTests: XCTestCase {
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
    
    func testRequest() async {
        let token = "abc"
        self.session.register(
            stub: MockHTTPSession.Stub(
                path: "/api/v1/\(token)/panelLayout/layout",
                method: .get,
                statusCode: 200,
                data: FetchPanelLayoutRequest.mock()
            )
        )
        
        let request = FetchPanelLayoutRequest(
            url: URL(string: "https://red.to")!,
            token: token
        )
        
        await XCTAsyncAssertNoThrow {
            _ = try await self.apiClient.execute(request: request)
        }
    }
}
