import Foundation

public struct PaletteColor {    
    public var hue: Double
    public var saturation: Double
    public var brightness: Double
    public var probability: Double?
    
    public var color: Color {
        .init(
            hue: self.hue,
            saturation: self.saturation,
            brightness: self.brightness,
            alpha: 1
        )
    }
}

extension PaletteColor: Codable {}
