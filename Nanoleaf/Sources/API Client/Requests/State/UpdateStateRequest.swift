import Foundation

/// Update a device's state.
///
/// This request can be used to update the device's:
/// - On/off status.
/// - Brightness.
/// - Hue.
/// - Saturation.
/// - Color temperature.
public struct UpdateStateRequest: HTTPRequest {
    public typealias ResponseObject = Void
    public typealias ErrorObject = APIError
    
    public let baseURL: URL
    public var method: HTTPMethod { .put }
    public var path: String { "/api/v1/\(self.token)/state" }
    public var isAuthenticated: Bool { true }
    public var body: Data?
    
    // Private
    private let token: String
    
    // MARK: Initialization
    
    /// Initialize a new instance.
    /// - Parameters:
    ///   - url: The device's URL.
    ///   - token: The device's token.
    ///   - isOn: The on/off state.
    ///   - brightness: The brightness mutation.
    ///   - hue: The hue mutation.
    ///   - saturation: The saturation mutation.
    ///   - colorTemperature: The color temperature mutation.
    public init(
        url: URL,
        token: String,
        isOn: Bool? = nil,
        brightness: ValueMutation? = nil,
        hue: ValueMutation? = nil,
        saturation: ValueMutation? = nil,
        colorTemperature: ValueMutation? = nil
    ) throws {
        self.baseURL = url
        self.token = token
        
        // Body
        var isOnValue: Value<Bool>?
        if let isOn = isOn {
            isOnValue = .init(value: isOn)
        }
        
        self.body = try Body(
            on: isOnValue,
            brightness: brightness,
            hue: hue,
            saturation: saturation,
            colorTemperature: colorTemperature
        ).encode()
    }
}

// MARK: Body

private struct Body: Codable {
    var on: Value<Bool>? = nil
    var brightness: ValueMutation? = nil
    var hue: ValueMutation? = nil
    var saturation: ValueMutation? = nil
    var colorTemperature: ValueMutation? = nil
    
    // MARK: Coding keys
    
    enum CodingKeys: String, CodingKey {
        case on
        case brightness
        case hue
        case saturation = "sat"
        case colorTemperature = "ct"
    }
}

// MARK: Ranged value mutation

/// Value mutation.
///
/// This struct provides an abstrated way of building
/// mutations for a device's state.
public struct ValueMutation: Codable {
    let value: Double?
    let duration: TimeInterval?
    let increment: Double?
    
    // MARK: Initialization
    
    /// Initialize a new `ValueMutation` instance that sets a value
    /// within an optional duration.
    ///
    /// For example, use this to change the brightness to 20%
    /// over a duration of 30 seconds.
    /// - Parameters:
    ///   - value: The value.
    ///   - duration: The duration.
    public init(value: Double, duration: TimeInterval? = nil) {
        self.value = value
        self.duration = duration
        self.increment = nil
    }
    
    /// Initialize a new `ValueMutation` instance that increments
    /// the value by the given amount.
    /// - Parameter increment: The amount to increment by.
    public init(increment: Double) {
        self.increment = increment
        self.value = nil
        self.duration = nil
    }
    
    /// Initialize a new `ValueMutation` instance that decrements
    /// the value by the given amount.
    /// - Parameter decrement: The amount to decrement by.
    public init(decrement: Double) {
        self.increment = -decrement
        self.value = nil
        self.duration = nil
    }
}
