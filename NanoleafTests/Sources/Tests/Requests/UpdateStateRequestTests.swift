import XCTest
@testable import Nanoleaf

class UpdateStateRequestTests: XCTestCase {
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
                path: "/api/v1/\(token)/state",
                method: .put,
                statusCode: 200,
                data: .init()
            )
        )
        
        let request = try UpdateStateRequest(
            url: URL(string: "https://red.to")!,
            token: token,
            isOn: true,
            brightness: .init(value: 10, duration: 10),
            saturation: .init(value: 10, duration: 10),
            colorTemperature: .init(value: 10, duration: 10)
        )
        
        try await self.apiClient.execute(request: request)
    }
}
