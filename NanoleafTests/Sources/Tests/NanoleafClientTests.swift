import XCTest
@testable import Nanoleaf

final class NanoleafClientTests: XCTestCase {
    private var apiClient: NanoleafClient!
    private var session: MockHTTPSession!
    
    // MARK: Setup
    
    override func setUpWithError() throws {
        self.session = MockHTTPSession()
        self.apiClient = NanoleafClient(session: self.session)
    }
    
    // MARK: Tests
    
    func testHandlingSuccessfulRequest() async throws {
        self.session.register(
            stub: MockHTTPSession.Stub(
                path: "/test",
                method: .get,
                statusCode: 200,
                data: try MockResponse().encode()
            )
        )
        
        var request = MockRequest()
        request.isAuthenticated = false
        
        await XCTAsyncAssertNoThrow {
            _ = try await self.apiClient.execute(request: request)
        }
    }
    
    func testHandlingUnsuccessfulRequest() async throws {
        self.session.register(
            stub: MockHTTPSession.Stub(
                path: "/test",
                method: .get,
                statusCode: APIErrorStatus.unauthorized.rawValue,
                data: try Empty().encode()
            )
        )
        
        var request = MockRequest()
        request.isAuthenticated = true
        
        do {
            _ = try await self.apiClient.execute(request: request)
        } catch let error as APIError {
            XCTAssertEqual(error, .init(status: .unauthorized))
        } catch {
            XCTFail("Incorrect error")
        }
    }
}
