import Foundation

extension HTTPURLResponse {
    var isSuccess: Bool { 200...299 ~= self.statusCode }
}
