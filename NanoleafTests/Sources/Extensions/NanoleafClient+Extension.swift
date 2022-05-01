@testable import Nanoleaf

extension NanoleafClient {
    static func mock(
        session: HTTPSession = MockHTTPSession()
    ) -> Self {
        .init(session: session)
    }
}
