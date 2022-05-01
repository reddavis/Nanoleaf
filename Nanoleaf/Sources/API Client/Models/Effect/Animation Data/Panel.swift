import Foundation

public struct Panel {
    public var id: Int
    public var frames: [AnimationDataFrame]
    
    // Internal
    
    /// Raw space seperated string represention of the panel.
    ///
    /// Values consist of:
    /// - Panel ID
    /// - Number of frames
    /// - Frame[0] red
    /// - Frame[0] green
    /// - Frame[0] blue
    /// - Frame[0] white
    /// - Frame[0] transition time
    /// - Frame[1] red
    /// - Frame[2] green
    /// - Frame[3] blue
    /// - Frame[4] white
    /// - Frame[5] transition time
    /// - etc.
    var rawRepresentation: String {
        let frameStringRepresentation = self.frames
            .map(\.rawRepresentation)
            .joined(separator: " ")
        
        return "\(self.id) \(self.frames.count) \(frameStringRepresentation)"
    }
    
    // MARK: Initialization
    
    init(id: Int, frameData: [Int]) throws {
        // Each frame has 5 values
        guard frameData.count % 5 == 0 else { throw PanelInitializationError.invalidNumberOfDataValues }
        
        self.id = id
        self.frames = try frameData
            .chunks(of: AnimationDataFrame.numberOfDataValues)
            .map(AnimationDataFrame.init)
    }
}

extension Panel: Equatable {}

// MARK: CustomStringConvertible

extension Panel: CustomStringConvertible {
    public var description: String {
        let frameStringRepresentation = self.frames
            .map(\.description)
            .joined(separator: "\n")
        
        return
"""
ID: \(self.id)
Frames:
\(frameStringRepresentation)
"""
    }
}

// MARK: Error

enum PanelInitializationError: Error {
    case invalidNumberOfDataValues
}
