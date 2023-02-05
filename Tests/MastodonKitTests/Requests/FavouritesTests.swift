//
//  FavouritesTests.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 5/17/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import XCTest
@testable import MastodonKit

class FavouritesTests: XCTestCase {
    func testAll() {
        let request = Requests.Favourites.All()

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/favourites")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNil(request.method.httpBody)
    }

    func testAllWithRange() {
        let request = Requests.Favourites.All(range: .since(id: "42", limit: nil))
        let expectedSinceID = URLQueryItem(name: "since_id", value: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/favourites")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems?.count, 1)
        XCTAssertTrue(request.method.queryItems!.contains(expectedSinceID))
    }
}
