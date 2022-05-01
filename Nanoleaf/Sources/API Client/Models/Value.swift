import Foundation

public struct Value<T: Codable & Equatable> {
    public var value: T
}

extension Value: Codable {}
extension Value: Equatable {}

// MARK: Fixture

extension Value {
    public static func fixture(_ configure: ((inout Value<Double>) -> Void)? = nil) -> Value<Double> {
        var fixture = Value<Double>(
            value: 5.0
        )
        configure?(&fixture)
        return fixture
    }
    
    public static func fixture(_ configure: ((inout Value<Int>) -> Void)? = nil) -> Value<Int> {
        var fixture = Value<Int>(
            value: 5
        )
        configure?(&fixture)
        return fixture
    }
}
