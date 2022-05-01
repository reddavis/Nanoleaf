import Foundation

public struct Effect {
    public var loop: Bool?
    public var version: String
    public var name: String
    public var type: AnimationType
    public var colorType: ColorType?
    public var data: AnimationData?
    public var brightnessRange: ValueRange<Double>?
    public var transitionTimeRange: ValueRange<Double>?
    public var delayTimeRange: ValueRange<Double>?
    public var palette: [PaletteColor]?
}

extension Effect: Codable {}

// MARK: Coding keys

extension Effect {
    enum CodingKeys: String, CodingKey {
        case loop
        case version
        case name = "animName"
        case type = "animType"
        case colorType
        case data = "animData"
        case brightnessRange
        case transitionTimeRange = "transTime"
        case delayTimeRange = "delayTime"
        case palette
    }
}
