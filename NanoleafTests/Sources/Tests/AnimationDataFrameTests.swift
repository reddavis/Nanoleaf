import XCTest
@testable import Nanoleaf

final class AnimationDataFrameTests: XCTestCase {
    func testInitialization() {
        XCTAssertNoThrow(try AnimationDataFrame([0, 1, 2, 3, 4]))
        XCTAssertThrowsError(try AnimationDataFrame([0, 1, 2, 3]))
    }
    
    func testRawRepresentation() throws {
        let frame = try AnimationDataFrame([1, 2, 3, 4, 5])
        XCTAssertEqual(frame.rawRepresentation, "1 2 3 4 5")
    }
    
    func testDataAllocation() throws {
        let red = 1
        let green = 2
        let blue = 3
        let white = 4
        let transitionTime = 5
        
        let frame = try AnimationDataFrame([red, green, blue, white, transitionTime])
        XCTAssertEqual(frame.white, white)
        XCTAssertEqual(frame.transitionTime, TimeInterval(transitionTime))
        
        XCTAssertEqual(
            frame.color,
            Color(
                red: CGFloat(red) / 255.0,
                green: CGFloat(green) / 255.0,
                blue: CGFloat(blue) / 255.0,
                alpha: 1.0
            )
        )
    }
}
