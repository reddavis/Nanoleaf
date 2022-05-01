import Foundation

public struct AnimationData {
    public var panels: [Panel]
    
    // Internal
    
    /// Raw space seperated string represention of the animation data.
    ///
    /// Values consist of:
    /// - Number of panels
    /// - Panel[0] ID
    /// - Panel[0] Number of frames
    /// - Panel[0]Frame[0] red
    /// - Panel[0]Frame[0] green
    /// - Panel[0]Frame[0] blue
    /// - Panel[0]Frame[0] white
    /// - Panel[0]Frame[0] transition time
    /// - Panel[1] ID
    /// - Panel[1] Number of frames
    /// - Panel[1]Frame[0] red
    /// - Panel[1]Frame[0] green
    /// - Panel[1]Frame[0] blue
    /// - Panel[1]Frame[0] white
    /// - Panel[1]Frame[0] transition time
    /// - etc.
    var rawRepresentation: String {
        let panelsStringRepresentation = self.panels
            .map(\.rawRepresentation)
            .joined(separator: " ")
        return "\(self.panels.count) \(panelsStringRepresentation)"
    }
}

extension AnimationData: Equatable {}

// MARK: Codable

extension AnimationData: Codable {
    // MARK: Initialization
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container
            .decode(String.self)
        
        var values = string
            .split(separator: " ")
            .compactMap(String.init)
            .compactMap(Int.init)
        
        guard !values.isEmpty else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid animation data structure"
            )
        }
        
        let numberOfPanels = values.remove(at: 0)
        self.panels = try (0..<numberOfPanels).map { _ in
            let id = values.remove(at: 0)
            let numberOfFrames = values.remove(at: 0)
            
            let range = 0..<(AnimationDataFrame.numberOfDataValues * numberOfFrames)
            let frameData = Array(values[range])
            values.removeSubrange(range)
            
            return try Panel(id: id, frameData: frameData)
        }
    }
    
    // MARK: Encode
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawRepresentation)
    }
}

// MARK: CustomStringConvertible

extension AnimationData: CustomStringConvertible {
    public var description: String {
        let panelDescriptions = self.panels
            .map(\.description)
            .joined(separator: "\n")
        return
"""
Number of panels: \(self.panels.count)
Panels: \(panelDescriptions)
"""
    }
}
