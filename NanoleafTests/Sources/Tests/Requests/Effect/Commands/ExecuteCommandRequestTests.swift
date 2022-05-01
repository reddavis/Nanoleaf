import XCTest
@testable import Nanoleaf

class ExecuteCommandRequestTests: XCTestCase {
    private var session: MockHTTPSession!
    private var apiClient: NanoleafClient!
    private let token = "abc"
    
    // MARK: Setup
    
    override func setUpWithError() throws {
        self.session = MockHTTPSession()
        self.apiClient = NanoleafClient.mock(
            session: self.session
        )
    }
    
    // MARK: Tests
    
    func testFetchingPlugins() async throws {
        self.session.register(
            stub: MockHTTPSession.Stub(
                path: "/api/v1/\(self.token)/effects",
                method: .put,
                statusCode: 200,
                data: CommandRequest.fetchPluginsMock()
            )
        )
        
        let request = try CommandRequest.fetchPlugins(
            url: URL(string: "https://red.to")!,
            token: self.token
        )
        
        _ = try await self.apiClient.execute(request: request)
    }
    
    func testFetchingEffects() async throws {
        self.session.register(
            stub: MockHTTPSession.Stub(
                path: "/api/v1/\(self.token)/effects",
                method: .put,
                statusCode: 200,
                data: CommandRequest.fetchEffectsMock()
            )
        )
        
        let request = try CommandRequest.fetchEffects(
            url: URL(string: "https://red.to")!,
            token: self.token
        )
        
        _ = try await self.apiClient.execute(request: request)
    }
}
