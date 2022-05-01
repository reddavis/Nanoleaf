import XCTest
@testable import Nanoleaf

final class SequenceTests: XCTestCase {
    func testGroupIntoSubgroups() {
        let array = [1, 2, 3, 4, 5, 6]
        var grouped = array.chunks(of: 2)
        
        XCTAssertEqual(grouped.count, 3)
        XCTAssertEqual(grouped[0].count, 2)
        
        grouped = array.chunks(of: 3)
        XCTAssertEqual(grouped.count, 2)
        XCTAssertEqual(grouped[0].count, 3)
        
        grouped = array.chunks(of: 4)
        XCTAssertEqual(grouped.count, 2)
        XCTAssertEqual(grouped[0].count, 4)
        XCTAssertEqual(grouped[1].count, 2)
    }
}
