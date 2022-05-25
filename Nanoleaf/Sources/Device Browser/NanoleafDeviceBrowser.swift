import Asynchrone
import Network

/// Browse Nanoleaf devices with Bonjour.
public final class NanoleafDeviceBrowser {
    // MARK: Initialization
    
    /// Initialize a new `NanoleafDeviceBrowser` instance.
    public init() {}
    
    // MARK: Devices
    
    /// An async sequence that emits devices found.
    public var identifiers: AnyAsyncSequenceable<[DeviceIdentifier]> {
        AsyncStream { continuation in
            let browser = self.buildBrowser { devices in
                continuation.yield(devices)
            }
            browser.start(queue: .main)
            
            continuation.onTermination = { @Sendable _ in
                browser.cancel()
            }
        }
        .eraseToAnyAsyncSequenceable()
    }
    
    // MARK: Browser
    
    private func buildBrowser(resultsChanged: @escaping (_ devices: [DeviceIdentifier]) -> Void) -> NWBrowser {
        let parameters = NWParameters()
        parameters.includePeerToPeer = true
        let browser = NWBrowser(
            for: .bonjour(type: "_nanoleafapi._tcp", domain: nil),
            using: parameters
        )
        
        browser.browseResultsChangedHandler = { results, _ in
            let devices: [DeviceIdentifier] = results.compactMap { result in
                switch result.endpoint {
                case .url, .unix, .hostPort:
                    return nil
                case .service(let name, let type, let domain, _):
                    return DeviceIdentifier(
                        name: name,
                        type: type,
                        domain: domain
                    )
                @unknown default:
                    return nil
                }
            }
            
            resultsChanged(devices)
        }
        
        return browser
    }
}
