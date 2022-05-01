import XCTest
@testable import Nanoleaf

final class AnimationDataTests: XCTestCase {
    func testDecodingEncoding() throws {
        let numberOfPanels = 1
        let panelID = 2
        let numberOfFrames = 1
        let red = 3
        let green = 4
        let blue = 5
        let white = 6
        let transitionTime = 7
        let data = try [
            numberOfPanels,
            panelID,
            numberOfFrames,
            red,
            green,
            blue,
            white,
            transitionTime
        ]
        .map(String.init)
        .joined(separator: " ")
        .encode()
        
        let decoder = JSONDecoder()
        let animationData = try decoder.decode(AnimationData.self, from: data)
        XCTAssertEqual(animationData.panels.count, 1)
        
        let panel = animationData.panels[0]
        let otherPanel = try Panel(id: panelID, frameData: [red, green, blue, white, transitionTime])
        XCTAssertEqual(panel, otherPanel)
        
        // Re-encode
        let reEncodedData = try animationData.encode()
        let decodedAnimationData = try decoder.decode(AnimationData.self, from: reEncodedData)
        XCTAssertEqual(animationData, decodedAnimationData)
    }
}
