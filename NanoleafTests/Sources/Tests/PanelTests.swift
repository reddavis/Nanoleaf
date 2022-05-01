import XCTest
@testable import Nanoleaf

final class PanelTests: XCTestCase {
    func testInitialization() throws {
        let panel = try Panel(id: 0, frameData: [1, 2, 3, 4, 5])
        XCTAssertEqual(panel.id, 0)
        XCTAssertEqual(panel.frames.count, 1)
    }
    
    func testInvalidInitialization() {
        XCTAssertThrowsError(try Panel(id: 0, frameData: [0, 1, 2, 3, 4, 5, 6, 7]))
    }
    
    func testRawRepresentation() throws {
        let panel = try Panel(id: 0, frameData: [1, 2, 3, 4, 5])
        XCTAssertEqual(panel.rawRepresentation, "0 1 1 2 3 4 5")
    }
}
