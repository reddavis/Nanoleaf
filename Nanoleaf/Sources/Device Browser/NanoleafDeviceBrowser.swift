import Asynchrone
import Network

/// Browse Nanoleaf devices with Bonjour.
public final class NanoleafDeviceBrowser {
    /// An async sequence that emits devices found.
    public var identifiers: AnyAsyncSequenceable<[DeviceIdentifier]>
    
    // Private
    private let _stream: CurrentElementAsyncSequence<[DeviceIdentifier]> = .init([])
    private var browser: NWBrowser?
    
    // MARK: Initialization
    
    /// Initialize a new `NanoleafDeviceBrowser` instance.
    public init() {
        self.identifiers = self._stream.shared().eraseToAnyAsyncSequenceable()
    }
    
    // MARK: API
    
    /// Start monitoring for Nanoleaf devices.
    public func start() {
        self.cancel()
        
        let browser = self.buildBrowser()
        browser.start(queue: .main)
        self.browser = browser
    }
    
    /// Stop monitoring for Nanoleaf devices.
    public func cancel() {
        self.browser?.cancel()
    }
    
    // MARK: Browser
    
    private func buildBrowser() -> NWBrowser {
        let parameters = NWParameters()
        parameters.includePeerToPeer = true
        let browser = NWBrowser(
            for: .bonjour(type: "_nanoleafapi._tcp", domain: nil),
            using: parameters
        )
        
        browser.browseResultsChangedHandler = { [_stream] results, _ in
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
            
            Task {
                await _stream.yield(devices)
            }
        }
        
        return browser
    }
}
