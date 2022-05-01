import Foundation
@testable import Nanoleaf

extension CommandRequest {
    static func fetchPluginsMock() -> Data {
        let url = Bundle(for: TestTargetClass.self).url(
            forResource: "FetchPlugins",
            withExtension: "json"
        )!
        
        return try! Data(contentsOf: url)
    }
    
    static func fetchEffectsMock() -> Data {
        let url = Bundle(for: TestTargetClass.self).url(
            forResource: "FetchEffects",
            withExtension: "json"
        )!
        
        return try! Data(contentsOf: url)
    }
}
