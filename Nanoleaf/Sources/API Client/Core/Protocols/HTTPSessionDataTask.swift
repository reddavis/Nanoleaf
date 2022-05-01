import Foundation

/// A shell protocol of `URLSessionDataTask`. Primarily used to make testing easier.
public protocol HTTPSessionDataTask {
    func resume()
    func cancel()
}
