import CoreGraphics

public struct AnimationDataFrame {
    static let numberOfDataValues = 5
    
    public var color: Color
    public var white: Int
    public var transitionTime: TimeInterval
    
    // Internal
    
    /// Raw space seperated string represention of the data frame.
    ///
    /// Values consist of:
    /// - red
    /// - green
    /// - blue
    /// - white
    /// - transition time
    var rawRepresentation: String {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        self.color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        red *= 255.0
        green *= 255.0
        blue *= 255.0
        
        return "\(Int(red)) \(Int(green)) \(Int(blue)) \(Int(self.white)) \(Int(self.transitionTime))"
    }
    
    // MARK: Initialization
    
    init(_ data: [Int]) throws {
        guard data.count == AnimationDataFrame.numberOfDataValues else {
            throw AnimationDataFrameInitializationError.invalidNumberOfDataValues
        }
        
        let red = Double(data[0])
        let green = Double(data[1])
        let blue = Double(data[2])
        let white = data[3]
        let transitionTime = TimeInterval(data[4])
        
        self.color = Color(
            red: red / 255.0,
            green: green / 255.0,
            blue: blue / 255.0,
            alpha: 1.0
        )
        
        self.white = white
        self.transitionTime = transitionTime
    }
}

extension AnimationDataFrame: Equatable {}

// MARK: CustomStringConvertible

extension AnimationDataFrame: CustomStringConvertible {
    public var description: String {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        self.color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        red *= 255.0
        green *= 255.0
        blue *= 255.0
        
        return
"""
Red: \(Int(red))/255
Green: \(Int(green))/255
Blue: \(Int(blue))/255
White: \(Int(self.white))
Transition Time:\(Int(self.transitionTime))
"""
    }
}

// MARK: Error

enum AnimationDataFrameInitializationError: Error {
    case invalidNumberOfDataValues
}
