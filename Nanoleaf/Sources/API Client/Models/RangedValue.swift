import Foundation

public struct RangedValue<T: Codable & Equatable> {
    public var value: T
    public var max: T
    public var min: T
}

extension RangedValue: Codable {}
extension RangedValue: Equatable {}

// MARK: Fixture

extension RangedValue {
    public static func fixture(_ configure: ((inout RangedValue<Double>) -> Void)? = nil) -> RangedValue<Double> {
        var fixture = RangedValue<Double>(
            value: 5.0,
            max: 10.0,
            min: 0.0
        )
        configure?(&fixture)
        return fixture
    }
    
    public static func fixture(_ configure: ((inout RangedValue<Int>) -> Void)? = nil) -> RangedValue<Int> {
        var fixture = RangedValue<Int>(
            value: 5,
            max: 10,
            min: 0
        )
        configure?(&fixture)
        return fixture
    }
}
