import XCTest
@testable import MastodonKit

final class BookmarksTests: XCTestCase {
    func testRequestAllDefaultLimit() throws {
        let request = Requests.Bookmarks.All()

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/bookmarks")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }
}
