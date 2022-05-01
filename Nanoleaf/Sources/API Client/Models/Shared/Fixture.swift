import Foundation

public protocol Fixture {
    static func fixture(_ configure: ((_ fixture: inout Self) -> Void)?) -> Self
}
