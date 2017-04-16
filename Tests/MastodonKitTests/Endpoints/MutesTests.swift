import XCTest
@testable import MastodonKit

class MutesTests: XCTestCase {
    static var allTests = [
        ("testAll", testAll)
    ]

    func testAll() {
        let resource = Mutes.all()

        XCTAssertEqual(resource.path, "/api/v1/mutes")
        XCTAssertEqual(resource.httpMethod, .get)
        XCTAssertNil(resource.parameters)

        XCTAssertTrue(type(of: resource.parse) == ParserFunctionType<[Account]>.self)
    }
}
