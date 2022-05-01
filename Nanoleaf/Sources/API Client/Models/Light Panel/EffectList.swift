import Foundation

public struct EffectList {
    public var current: String
    public var all: [String]
}

extension EffectList: Codable {}
extension EffectList: Equatable {}

// MARK: Coding keys

extension EffectList {
    enum CodingKeys: String, CodingKey {
        case current = "select"
        case all = "effectsList"
    }
}

// MARK: Fixture

extension EffectList: Fixture {
    public static func fixture(_ configure: ((inout Self) -> Void)? = nil) -> Self {
        var fixture = EffectList(
            current: "a",
            all: ["a", "b", "c"]
        )
        configure?(&fixture)
        return fixture
    }
}
