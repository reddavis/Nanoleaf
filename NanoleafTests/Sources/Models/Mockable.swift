import Foundation

protocol Mockable {
    static func mock() -> Data
}

// MARK: Default implementation

extension Mockable {
    static func mock() -> Data {
        let url = Bundle(for: TestTargetClass.self).url(
            forResource: String(describing: self),
            withExtension: "json"
        )!
        
        return try! Data(contentsOf: url)
    }
}
