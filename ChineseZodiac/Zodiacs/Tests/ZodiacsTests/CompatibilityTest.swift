import XCTest
@testable import Zodiacs

final class CompatibilityTest: XCTestCase {
    func testRatOx_ShouldBePerfect() {
        let result = ChineseZodiac.rat.compatibility(with: .ox)
        let expectation = Compatibility.perfect
        XCTAssertEqual(result, expectation)
    }

    func testPigPig_ShouldBeGoodMatchOrEnemy() {
        let result = ChineseZodiac.pig.compatibility(with: .pig)
        let expectation = Compatibility.goodMatchOrEnemy
        XCTAssertEqual(result, expectation)
    }
}
