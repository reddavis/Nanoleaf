import Foundation

extension Encodable {
    func encode(with encoder: JSONEncoder = .init()) throws -> Data {
        try encoder.encode(self)
    }
}
