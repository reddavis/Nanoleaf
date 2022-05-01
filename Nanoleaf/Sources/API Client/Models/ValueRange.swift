import Foundation

public struct ValueRange<T: Codable> {
    public var min: T
    public var max: T
}

extension ValueRange: Codable {}

// MARK: Coding keys

extension ValueRange {
    enum CodingKeys: String, CodingKey {
        case min = "minValue"
        case max = "maxValue"
    }
}

// MARK: Fixture

extension ValueRange {
    public static func fixture(_ configure: ((inout ValueRange<Double>) -> Void)? = nil) -> ValueRange<Double> {
        var fixture = ValueRange<Double>(
            min: 0.0,
            max: 10.0
        )
        configure?(&fixture)
        return fixture
    }
    
    public static func fixture(_ configure: ((inout ValueRange<Int>) -> Void)? = nil) -> ValueRange<Int> {
        var fixture = ValueRange<Int>(
            min: 0,
            max: 10
        )
        configure?(&fixture)
        return fixture
    }
}
