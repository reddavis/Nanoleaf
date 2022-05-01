import Foundation

public struct Auth {
    public var token: String
}

extension Auth: Codable {}

// MARK: Coding keys

extension Auth {
    enum CodingKeys: String, CodingKey {
        case token = "auth_token"
    }
}

// MARK: Fixture

extension Auth: Fixture {
    public static func fixture(_ configure: ((inout Self) -> Void)? = nil) -> Self {
        var fixture = Auth(token: "1")
        configure?(&fixture)
        return fixture
    }
}
